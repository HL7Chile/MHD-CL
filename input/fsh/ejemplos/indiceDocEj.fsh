Alias: LNC = http://loinc.org

Instance: ReferDocEjemplo
InstanceOf: ReferenciaDocumental
Usage: #example
Title: "Referencia documental mínima para DocumentoArg"
Description: "Ejemplo de DocumentReference MHD que referencia un documento clínico FHIR DocumentoArg."

// Perfil
* meta.profile = Canonical(ReferenciaDocumental)

// Identificador principal del documento clínico referenciado.
// Debe coincidir idealmente con el identificador del documento publicado.
* masterIdentifier.system = "https://repositorio.hsi.ar/documentos/ips"
* masterIdentifier.value = "IPS-ARG-2026-00001"

// Estado de la referencia documental
* status = #current

// Tipo documental.
// Según el perfil, para IPS se ejemplifica con LOINC 34133-9.
* type = LNC#34133-9 "Summary of episode note"

// Categoría documental.
// Según el perfil, para IPS se ejemplifica con LOINC 60591-5.
* category = LNC#60591-5 
* category.text = "Resumen clínico de paciente"

// Paciente externo, no generado aquí
* subject.reference = "urn:uuid:991a7102-d221-498d-9157-c4192934e3b7"

// Fecha de creación / indexación de la referencia documental
* date = "2026-07-06T10:30:00-03:00"

// Autor del documento referenciado.
// En el DocumentoArg anterior el autor iba por identifier;
// aquí DocumentReference sí permite author como Reference.
* author[0] = Reference(PrestadorArgInline)


// Contenido del documento referenciado.
// El perfil exige attachment.contentType = application/fhir+json
// y attachment.url 1..1.
// Puede apuntar a Bundle document o Binary.
* content.attachment.contentType = #application/fhir+json
* content.attachment.url = "https://SecServerPEPE:2012/pba/santamarina/docs/ips-123"
* content.attachment.title = "Documento IPS argentino mínimo"
* content.attachment.creation = "2026-07-06T10:30:00-03:00"
/*
// Opcional, pero útil si quieres usar la extensión ContentDoc.
// Importante: se usa valueAttachment, no content.extension[ContentDoc].contentType.
* content.extension[ContentDoc].valueAttachment.contentType = #application/fhir+json
* content.extension[ContentDoc].valueAttachment.url = "Bundle/bundleEjemplo"
* content.extension[ContentDoc].valueAttachment.title = "Documento IPS argentino mínimo"
*/
// El perfil deja context 1..1.
// Como context es un BackboneElement, conviene darle al menos un hijo.
* context.period.start = "2026-07-06T10:30:00-03:00"
