Instance: EjemploListMhd
InstanceOf: ListMhd
Usage: #example
Title: "Ejemplo mínimo de List MHD"
Description: "Ejemplo mínimo de List como SubmissionSet MHD con una referencia documental."

* meta.profile = Canonical(ListMhd)

// Obligatorio por el perfil base MHD: sourceId 1..1
// La extensión ihe-sourceId usa valueIdentifier y representa un OID de la fuente publicadora.
* extension[sourceId].valueIdentifier.system = "urn:ietf:rfc:3986"
* extension[sourceId].valueIdentifier.value = "urn:oid:2.16.840.1.113883.3.9999.1"

// Patrones obligatorios del perfil MHD SubmissionSet
* status = #current
* mode = #working
* code = https://profiles.ihe.net/ITI/MHD/CodeSystem/MHDlistTypes#submissionset

// Obligatorio en el perfil
* date = "2026-07-06"

// Opcional, pero útil porque tu perfil restringe subject a PacienteArg
* subject.reference = "urn:uuid:991a7102-d221-498d-9157-c4192934e3b7"
* subject.display = "Paciente argentino de ejemplo"

// Entrada del listado: referencia a un DocumentReference que cumple ReferenciaDocumental
* entry[0].item.reference = "urn:uuid:32ab6cfe-8cdf-4c75-a831-47be8b5668fa"
* entry[0].item.display = "Referencia documental de ejemplo"