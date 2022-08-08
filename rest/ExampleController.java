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
package com.intland.codebeamer.controller.rest.v2;

import com.intland.codebeamer.manager.TrackerItemManager;
import com.intland.codebeamer.persistence.dto.example.ExampleDto;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.intland.codebeamer.controller.rest.v2.exception.TooManyRequestsException;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;

@OpenAPIDefinition
@RestController
@RequestMapping(AbstractRestController.API_URI_V3)
public class ExampleController extends AbstractRestController {

    @Operation(summary = "Get example greetings", tags = "Example")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "Hello PTC"),
            @ApiResponse(responseCode = "403", description = "Authentication is required"),
            @ApiResponse(responseCode = "404", description = "Not found"),
            @ApiResponse(responseCode = "429", description = "Too many requests", content = @Content(schema = @Schema(implementation = TooManyRequestsException.class)))
    })
    @RequestMapping(value = "example", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody ExampleDto getHello() {
        ExampleDto exampleDto = new ExampleDto("Hello PTC!");
        return exampleDto;
    }
}
