

Profile: ListMhd
Parent: SubmissionSet
Id: ListMhd
Description: "Perfil asociado al listado de documentos referenciados para HSI en un modelo MHD"
* ^status = #draft
* ^publisher = "HL7 Chile"
* ^contact.name =  "HL7 Chile"
* ^contact.telecom.system = #url
* ^contact.telecom.value = "https://hl7chile.cl"
* ^jurisdiction = urn:iso:std:iso:3166#CL "Chile"



* subject only Reference(PacienteCl)
* entry.item only Reference(ReferenciaDocumental)

/*
Mapping: SubmissionSet-Mapping
Id: SubmissionSet-Mapping
Title: "XDS and MHD Mapping"
Source: ListAR
Target: "XDS"

Mapping: rim
Id: rim
Title: "RIM Mapping"
Source: ListAR
Target: "http://hl7.org/v3"

Mapping: w5
Id: w5
Title: "FiveWs Pattern Mapping"
Source: ListAR
Target: "http://hl7.org/fhir/fivews"
*/