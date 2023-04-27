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

package com.intland.codebeamer.event.impl;

import com.intland.codebeamer.event.FileUploadEventData;
import com.intland.codebeamer.event.FileUploadListener;
import com.intland.codebeamer.event.util.VetoException;
import org.springframework.stereotype.Component;

import java.io.File;

@Component("limitFileUpload")
public class LimitFileUpload implements FileUploadListener {

    private static double MAX_FILE_SIZE_IN_MB = 100;
    @Override
    public void fileUploaded(FileUploadEventData event) throws VetoException {
        File file = event.getSource();
        if (!file.exists() || !file.isFile())
            return;
        double fileSize = getFileSizeMegaBytes(file);
        if(fileSize > MAX_FILE_SIZE_IN_MB) {
            throw new VetoException("File is too big!");
        }
    }

    private static double getFileSizeMegaBytes(File file) {
        return (double) file.length() / (1024 * 1024);
    }
}
