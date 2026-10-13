Instance: BundleMhdEjemplo
InstanceOf: BundleMhd
Usage: #example
Title: "Bundle MHD con referencia documental de ejemplo"
Description: "Bundle transaction que vincula el DocumentReference generado previamente."

* id = "bundle-mhd-referencia-documental-ejemplo"

* meta.profile = Canonical(BundleMhd)

* type = #transaction
* timestamp = "2026-07-06T12:00:00-03:00"

// List / SubmissionSet MHD que vincula el DocumentReference
* entry[SubmissionSet].fullUrl = "urn:uuid:bfc14381-eb19-49fe-b1ea-834e7fce07f9"
* entry[SubmissionSet].resource = EjemploListMhd
* entry[SubmissionSet].request.method = #POST
* entry[SubmissionSet].request.url = "List"

* entry[DocumentRefs].fullUrl = "urn:uuid:32ab6cfe-8cdf-4c75-a831-47be8b5668fa"
* entry[DocumentRefs].resource = ReferDocEjemplo
* entry[DocumentRefs].request.method = #POST
* entry[DocumentRefs].request.url = "/DocumentReference"

// Paciente
* entry[Patient].fullUrl = "urn:uuid:991a7102-d221-498d-9157-c4192934e3b7"
* entry[Patient].resource = Paciente-Interno
* entry[Patient].request.method = #POST
* entry[Patient].request.url = "Patient"






