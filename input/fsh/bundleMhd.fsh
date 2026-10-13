Alias: $IHE.MHD.Minimal.ProvideBundle = https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Minimal.ProvideBundle
Alias: $ListAR = https://conectaton.msal.gob.ar/StructureDefinition/ListAR
Alias: $DocumentReferenceOrigenAR = https://conectaton.msal.gob.ar/StructureDefinition/DocumentReferenceOrigenAR
Alias: $BundleDocAR = https://conectaton.msal.gob.ar/StructureDefinition/BundleDocAR

Profile: BundleMhd
Parent: MinimalProvideDocumentBundle
Id: BundleMhd
Description: "Perfil asociado al bundle de transacciones MHD, considerando la asociación de documentos de tipo IPS, referenciados a la Guía Core Argentna AR.FHIR.CORE"
* ^status = #draft
* ^date = "2026-06-22"
* ^publisher = "HSI Pladema"
* ^contact.name = "HSI Pladema"
* ^contact.telecom.system = #url
* ^contact.telecom.value = "https://hsi.pladema.net"
* ^jurisdiction = urn:iso:std:iso:3166#AR

* meta
  * profile 1..* MS
    * ^short = "Perfil asociado al bundle de transacciones MHD"
    * ^definition = "Perfil asociado al bundle de transacciones MHD, considerando la asociación de documentos de tipo IPS, referenciados a la Guía Core Argentna AR.FHIR.CORE"
    * ^example[0].label = "Ejemplo de perfil asociado al bundle de transacciones MHD"
    * ^example[0].valueUri = Canonical(BundleMhd)


* type = #transaction
  * ^short = "document|transaction|batch|searchset|history|collection|message|event|parameters"
  * ^definition = "Tipo de bundle asociado a transacciones MHD, considerando la asociación"

* entry[SubmissionSet] MS
* entry[DocumentRefs] MS
* entry[FhirDocuments] MS
* entry[Patient] MS
* entry[UpdateDocumentRefs] MS
* entry[Documents] MS
* entry[Folders] MS

* entry[SubmissionSet].resource only ListMhd 
* entry[SubmissionSet].request.method = #POST
* entry[SubmissionSet].request.url = "List"
* entry[DocumentRefs].resource only ReferenciaDocumental
* entry[DocumentRefs].request.method = #POST
* entry[DocumentRefs].request.url = "/DocumentReference"
* entry[FhirDocuments].resource only BundleDocArg
* entry[FhirDocuments].request.method = #POST
* entry[FhirDocuments].request.url = "Bundle"
* entry[Patient].resource only PacienteArg
* entry[Patient].request.method ^short = "GET|POST|PUT|DELETE|PATCH"
* entry[Patient].request.url = "Patient"


/*
Mapping: v2
Id: v2
Title: "HL7 v2 Mapping"
Source: BundleTransaccAR
Target: "http://hl7.org/v2"

Mapping: rim
Id: rim
Title: "RIM Mapping"
Source: BundleTransaccAR
Target: "http://hl7.org/v3"

Mapping: cda
Id: cda
Title: "CDA (R2)"
Source: BundleTransaccAR
Target: "http://hl7.org/v3/cda"

Mapping: w5
Id: w5
Title: "FiveWs Pattern Mapping"
Source: BundleTransaccAR
Target: "http://hl7.org/fhir/fivews"
*/