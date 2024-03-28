
package com.team.dto.asosdalyinfo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class AsosDalyInfo {
    public Response response;
}
