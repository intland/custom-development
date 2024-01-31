package com.intland.codebeamer.controller.rest.v2;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.intland.codebeamer.background.job.BackgroundJobManager;
import com.intland.codebeamer.controller.rest.v2.exception.InternalServerErrorException;
import com.intland.codebeamer.controller.rest.v2.exception.ResourceForbiddenException;
import com.intland.codebeamer.controller.rest.v2.exception.ResourceNotFoundException;
import com.intland.codebeamer.controller.rest.v2.exception.ResourceUnauthorizedException;
import com.intland.codebeamer.controller.rest.v2.exception.TooManyRequestsException;
import com.intland.codebeamer.persistence.dao.BackgroundJobDao;
import com.intland.codebeamer.persistence.dto.UserDto;
import com.intland.codebeamer.stepjobs.builder.MyJobBuilder;
import com.intland.codebeamer.stepjobs.builder.MyJobInitContext;

import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;

@OpenAPIDefinition
@RestController
@RequestMapping(AbstractRestController.API_URI_V3)
public class BackgroundJobController extends AbstractUserAwareRestController {
	
	@Autowired
	private BackgroundJobManager backgroundJobManager;
	
	@Autowired
	private BackgroundJobDao backgroundJobDao;
	
	@Operation(summary = "Start my background job", tags = "MyBackgroundJob")
	@ApiResponses(value = { @ApiResponse(responseCode = "200", description = "Project"),
			@ApiResponse(responseCode = "401", description = "Authentication is required", content = @Content(schema = @Schema(implementation = ResourceUnauthorizedException.class))),
			@ApiResponse(responseCode = "403", description = "Authentication is required", content = @Content(schema = @Schema(implementation = ResourceForbiddenException.class))),
			@ApiResponse(responseCode = "404", description = "Project not found", content = @Content(schema = @Schema(implementation = ResourceNotFoundException.class))),
			@ApiResponse(responseCode = "429", description = "Too many requests", content = @Content(schema = @Schema(implementation = TooManyRequestsException.class))) })
	@RequestMapping(value = "start", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
	public Integer start(@Parameter(hidden = true) UserDto user)
			throws ResourceNotFoundException, ResourceForbiddenException, ResourceUnauthorizedException, InternalServerErrorException {
		return backgroundJobManager.createBackgroundJob(new MyJobBuilder(new MyJobInitContext(user.getId())));
	}

	@Operation(summary = "Get context information of the background job", tags = "MyBackgroundJob")
	@ApiResponses(value = { @ApiResponse(responseCode = "200", description = "Project"),
			@ApiResponse(responseCode = "401", description = "Authentication is required", content = @Content(schema = @Schema(implementation = ResourceUnauthorizedException.class))),
			@ApiResponse(responseCode = "403", description = "Authentication is required", content = @Content(schema = @Schema(implementation = ResourceForbiddenException.class))),
			@ApiResponse(responseCode = "404", description = "Project not found", content = @Content(schema = @Schema(implementation = ResourceNotFoundException.class))),
			@ApiResponse(responseCode = "429", description = "Too many requests", content = @Content(schema = @Schema(implementation = TooManyRequestsException.class))) })
	@RequestMapping(value = "context/{jobId}", method = RequestMethod.GET, produces = MediaType.TEXT_PLAIN_VALUE)
	public String getContext(@PathVariable("jobId") Integer jobId, @Parameter(hidden = true) UserDto user)
			throws ResourceNotFoundException, ResourceForbiddenException, ResourceUnauthorizedException, InternalServerErrorException {
		return backgroundJobDao.loadStepContext(jobId);
	}
	
}