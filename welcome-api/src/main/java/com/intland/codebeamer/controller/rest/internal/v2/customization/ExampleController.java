package com.intland.codebeamer.controller.rest.internal.v2.customization;

import com.intland.codebeamer.controller.rest.v2.AbstractRestController;
import com.intland.codebeamer.controller.rest.v2.exception.*;
import org.apache.log4j.Logger;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import io.swagger.v3.oas.annotations.OpenAPIDefinition;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;

@OpenAPIDefinition
@RestController
@RequestMapping(AbstractRestController.API_URI_V3)
public class ExampleController extends AbstractRestController
{
    public static final Logger logger = Logger.getLogger(ExampleController.class);

    @Operation(summary = "Get example greetings", tags = "Example")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "OK "),
            @ApiResponse(responseCode = "403", description = "Authentication is required"),
            @ApiResponse(responseCode = "404", description = "Not found"),
            @ApiResponse(responseCode = "429", description = "Too many requests", content = @Content(schema = @Schema(implementation = TooManyRequestsException.class)))
    })
    @RequestMapping(value = "example", method = RequestMethod.GET, produces = MediaType.TEXT_PLAIN_VALUE)
    public @ResponseBody String getHello() {
        return "Hello PTC!";
    }
}
