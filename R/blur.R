# Copyright 2018 Indiana Nikel
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and limitations under the License.


library(png)
library(testit)

#' Blur
#'
#' @param input_path string, path for the input png file
#' @param output_path string, path for the output png file
#'
#' @return a png file at the specified output path
#' @export
#'
#' @examples
#' #' blur("input.png", "blur.png")

blur <- function(input_path, output_path) {

    assert("Please provide a string as the path for the input image file.", is.character(input_path))
    assert("Please provide a string as the path for the output image file.", is.character(output_path))

    input <- readPNG(input_path)
    output <- input[1:(length(input[,1,1])-2), 1:(length(input[1,,1])-2),]

    for (i in c(3:length(input[,1,1])-1)) {
        for (j in c(3:length(input[1,,1])-1)) {

            R <- c(input[i-1,j-1,1],
            input[i-1,j,1],
            input[i-1,j+1,1],
            input[i,j-1,1],
            input[i,j,1],
            input[i,j+1,1],
            input[i+1,j-1,1],
            input[i+1,j,1],
            input[i+1,j+1,1])

            G <- c(input[i-1,j-1,2],
            input[i-1,j,2],
            input[i-1,j+1,2],
            input[i,j-1,2],
            input[i,j,2],
            input[i,j+1,2],
            input[i+1,j-1,2],
            input[i+1,j,2],
            input[i+1,j+1,2])

            B <- c(input[i-1,j-1,3],
            input[i-1,j,3],
            input[i-1,j+1,3],
            input[i,j-1,3],
            input[i,j,3],
            input[i,j+1,3],
            input[i+1,j-1,3],
            input[i+1,j,3],
            input[i+1,j+1,3])

            output[i-1,j-1,1] <- sum(R)/9
            output[i-1,j-1,2] <- sum(G)/9
            output[i-1,j-1,3] <- sum(B)/9
        }
    }
    writePNG(output, target=output_path)
}
