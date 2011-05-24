header["Bcc"] = header["From"]
header["Reply-to"] ||= header["From"]
header["Return-path"] ||= header["From"]
