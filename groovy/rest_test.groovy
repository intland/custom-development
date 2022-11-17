import com.intland.codebeamer.persistence.dto.*;
import com.intland.codebeamer.persistence.dto.base.*;
import com.intland.codebeamer.persistence.dao.*;
import com.intland.codebeamer.manager.*;
import com.intland.codebeamer.controller.importexport.*;
import org.apache.commons.lang3.*

import java.nio.charset.StandardCharsets;

if (!beforeEvent) {
  return;
}

String Auth;
String user="bond";
String pass="007";
Auth = Base64.getEncoder().encodeToString((user +":"+ pass).getBytes(StandardCharsets.UTF_8));

def get = new URL("http://galatea.intland.de:8080/api/v3/items/1869").openConnection();

get.addRequestProperty("Authorization", "Basic "+Auth);

def getRC = get.getResponseCode();

if (getRC.equals(200)) {
  def text = get.getInputStream().getText();

  subject.setCustomField(0, text);
}
