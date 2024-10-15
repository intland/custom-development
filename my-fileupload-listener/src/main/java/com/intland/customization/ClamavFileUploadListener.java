package com.intland.customization;

import java.nio.file.Path;

import org.springframework.stereotype.Component;

import com.intland.codebeamer.event.FileUploadEventData;
import com.intland.codebeamer.event.FileUploadListener;
import com.intland.codebeamer.event.util.VetoException;

import xyz.capybara.clamav.ClamavClient;
import xyz.capybara.clamav.ClamavException;
import xyz.capybara.clamav.commands.scan.result.ScanResult;

@Component
public class ClamavFileUploadListener implements FileUploadListener {

	private final ClamavClient clamavClient;

	public ClamavFileUploadListener() {
		this.clamavClient = new ClamavClient("127.0.0.1");
	}

	@Override
	public void fileUploaded(FileUploadEventData event) throws VetoException {
		try {
			Path filePath = event.getSource().toPath();
			ScanResult scanResult = clamavClient.scan(filePath);
			if (scanResult instanceof ScanResult.VirusFound virusFound) {
				throw new VetoException("Virus found during scan: " + virusFound.getFoundViruses());
			}
		} catch (ClamavException ex) {
			throw new VetoException(ex);
		}
	}
}
