/*
 * Copyright by Intland Software
 *
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Intland Software. ("Confidential Information"). You
 * shall not disclose such Confidential Information and shall use
 * it only in accordance with the terms of the license agreement
 * you entered into with Intland.
 */
package com.intland.codebeamer.controller.rest.internal.v2.customization;

import java.io.File;
import java.io.IOException;
import java.io.Serializable;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.stream.Stream;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.springframework.http.MediaType;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.intland.codebeamer.controller.rest.v2.AbstractRestController;
import com.intland.codebeamer.controller.rest.v2.exception.InternalServerErrorException;
import com.intland.codebeamer.controller.rest.v2.exception.ResourceForbiddenException;
import com.intland.codebeamer.controller.rest.v2.exception.ResourceLockedException;
import com.intland.codebeamer.controller.rest.v2.exception.ResourceNotFoundException;
import com.intland.codebeamer.controller.rest.v2.exception.TooManyRequestsException;
import com.intland.codebeamer.persistence.dao.impl.EntityCache;
import com.intland.codebeamer.persistence.dto.UserDto;
import com.intland.codebeamer.servlet.CBPaths;
import com.intland.codebeamer.taglib.UrlVersionedService;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;

/**
 * @author <a href="mailto:sandor.zelei@intland.com">Sandor Zelei</a>
 */
@OpenAPIDefinition
@RestController
@RequestMapping("customizations")
@Validated
public class CustomizationRestController extends AbstractRestController {

    @Operation(summary = "Upload a customization", tags = "Customization")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Customization is uploaded"),
            @ApiResponse(responseCode = "403", description = "Authentication is required", content = @Content(schema = @Schema(implementation = ResourceForbiddenException.class))),
            @ApiResponse(responseCode = "429", description = "Too many requests", content = @Content(schema = @Schema(implementation = TooManyRequestsException.class)))
    })
    @RequestMapping(method = RequestMethod.POST, consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody List<String> uploadCustomization(
            @Parameter(hidden = true) HttpServletRequest request,
            @Parameter(hidden = true) UserDto user,
            @Valid UploadCustomizationModel uploadCustomization)
            throws ResourceForbiddenException, ResourceNotFoundException, ResourceLockedException, InternalServerErrorException {

        if (!EntityCache.getInstance(user).isSystemAdmin()) {
            throw new ResourceForbiddenException("Only System admin can upload files", "customizations");
        }

        try {
            for (MultipartFile multipartFile : uploadCustomization.getFiles()) {
                File customizationFile = new File(CBPaths.getInstance().getExternalScriptsDir(),
                        multipartFile.getOriginalFilename()).toPath().normalize().toFile();
                FileUtils.delete(customizationFile);
                String content = IOUtils.toString(multipartFile.getInputStream(), StandardCharsets.UTF_8);
                FileUtils.write(customizationFile, content, StandardCharsets.UTF_8);
            }

            UrlVersionedService.getInstance().resetVersionParam();

            try (Stream<Path> stream = Files.list(CBPaths.getInstance().getExternalScriptsDir().toPath())) {
                return stream
                        .filter(path -> !Files.isDirectory(path))
                        .map(path -> path.getFileName().toString())
                        .toList();
            }
        } catch (IOException e) {
            throw new InternalServerErrorException(e.getMessage());
        }
    }

    @Operation(summary = "Remove a customization", tags = "Customization")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Customization is removed"),
            @ApiResponse(responseCode = "403", description = "Authentication is required", content = @Content(schema = @Schema(implementation = ResourceForbiddenException.class))),
            @ApiResponse(responseCode = "429", description = "Too many requests", content = @Content(schema = @Schema(implementation = TooManyRequestsException.class)))
    })
    @RequestMapping(method = RequestMethod.DELETE, consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody List<String> deleteCustomization(
            @Parameter(hidden = true) HttpServletRequest request,
            @Parameter(hidden = true) UserDto user,
            @Parameter(required = true) @RequestBody DeleteCustomizationModel deleteCustomization)
            throws ResourceForbiddenException, ResourceNotFoundException, ResourceLockedException, InternalServerErrorException {

        if (!EntityCache.getInstance(user).isSystemAdmin()) {
            throw new ResourceForbiddenException("Only System admin can upload files", "customizations");
        }

        try {

            for (String fileNames : deleteCustomization.getFiles()) {
                File customizationFile = new File(CBPaths.getInstance().getExternalScriptsDir(), fileNames).toPath().normalize().toFile();
                FileUtils.deleteQuietly(customizationFile);
            }

            UrlVersionedService.getInstance().resetVersionParam();

            try (Stream<Path> stream = Files.list(CBPaths.getInstance().getExternalScriptsDir().toPath())) {
                return stream
                        .filter(path -> !Files.isDirectory(path))
                        .map(path -> path.getFileName().toString())
                        .toList();
            }
        } catch (IOException e) {
            throw new InternalServerErrorException(e.getMessage());
        }
    }

    @Schema(name = "DeleteCustomization")
    public static class DeleteCustomizationModel implements Serializable {

        @Schema(description = "Customization files")
        private List<String> files;

        public List<String> getFiles() {
            return files;
        }

        public void setFiles(List<String> files) {
            this.files = files;
        }

        @Override
        public int hashCode() {
            return HashCodeBuilder.reflectionHashCode(this);
        }

        @Override
        public boolean equals(Object obj) {
            return EqualsBuilder.reflectionEquals(this, obj);
        }

        @Override
        public String toString() {
            return ToStringBuilder.reflectionToString(this);
        }

    }

    @Schema(name = "UploadCustomization")
    public static class UploadCustomizationModel implements Serializable {

        @Schema(description = "Customization", type = "binary")
        private List<MultipartFile> files;

        public List<MultipartFile> getFiles() {
            return files;
        }

        public void setFiles(List<MultipartFile> files) {
            this.files = files;
        }

        @Override
        public int hashCode() {
            return HashCodeBuilder.reflectionHashCode(this);
        }

        @Override
        public boolean equals(Object obj) {
            return EqualsBuilder.reflectionEquals(this, obj);
        }

        @Override
        public String toString() {
            return ToStringBuilder.reflectionToString(this);
        }

    }

}
