Alias: LNC = http://loinc.org
Alias: SCT = http://snomed.info/sct
Alias: CVX = http://hl7.org/fhir/sid/cvx
Alias: CondClinical = http://terminology.hl7.org/CodeSystem/condition-clinical
Alias: CondVerStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status
Alias: AllClinical = http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical
Alias: AllVerStatus = http://terminology.hl7.org/CodeSystem/allergyintolerance-verification

Alias: ConditionUvIps = http://hl7.org/fhir/uv/ips/StructureDefinition/Condition-uv-ips
Alias: MedicationStatementUvIps = http://hl7.org/fhir/uv/ips/StructureDefinition/MedicationStatement-uv-ips
Alias: AllergyIntoleranceUvIps = http://hl7.org/fhir/uv/ips/StructureDefinition/AllergyIntolerance-uv-ips


Instance: BundleDocumentoIpsEjemplo
InstanceOf: BundleDocumentoIPSCl
Usage: #example
Title: "Bundle documento IPS Chile de ejemplo"
Description: "Bundle de tipo document: Composition como primera entrada, seguido del paciente, el autor y los recursos clínicos referenciados por las secciones."

* identifier.system = "https://fhirserver.hl7chile.cl/fhir/Bundle"
* identifier.value = "DOC-IPS-CL-0001"
* type = #document
* timestamp = "2026-07-06T10:30:00-03:00"

// La Composition debe ser la primera entrada
* entry[composition].fullUrl = "urn:uuid:5e1c2f0a-7b0d-4c55-9a43-0c1f6a1d0001"
* entry[composition].resource = ComposicionIps-Ejemplo

* entry[patient].fullUrl = "urn:uuid:991a7102-d221-498d-9157-c4192934e3b7"
* entry[patient].resource = Paciente-Interno

* entry[practitioner].fullUrl = "urn:uuid:5e1c2f0a-7b0d-4c55-9a43-0c1f6a1d0002"
* entry[practitioner].resource = PrestadorCLInline

* entry[immunization].fullUrl = "urn:uuid:5e1c2f0a-7b0d-4c55-9a43-0c1f6a1d0003"
* entry[immunization].resource = InmunizacionArg-Inline

* entry[condition].fullUrl = "urn:uuid:5e1c2f0a-7b0d-4c55-9a43-0c1f6a1d0004"
* entry[condition].resource = CondicionIps-Inline

* entry[medicationstatement].fullUrl = "urn:uuid:5e1c2f0a-7b0d-4c55-9a43-0c1f6a1d0005"
* entry[medicationstatement].resource = MedicacionIps-Inline

* entry[allergyintolerance].fullUrl = "urn:uuid:5e1c2f0a-7b0d-4c55-9a43-0c1f6a1d0006"
* entry[allergyintolerance].resource = AlergiaIps-Inline


// =====================================================
// Composition
// =====================================================
Instance: ComposicionIps-Ejemplo
InstanceOf: DocumentoClIps
Usage: #inline
Title: "Composition IPS Chile de ejemplo"
Description: "Composition del documento IPS; sus secciones referencian las entradas del Bundle por fullUrl."

* identifier.system = "https://fhirserver.hl7chile.cl/fhir/Composition"
* identifier.value = "DOC-IPS-CL-0001"

* status = #final
* type = LNC#60591-5 "Patient summary Document"

* subject.reference = "urn:uuid:991a7102-d221-498d-9157-c4192934e3b7"
* subject.display = "Pablo Fernandez Perez"

* date = "2026-07-06T10:30:00-03:00"

* author.reference = "urn:uuid:5e1c2f0a-7b0d-4c55-9a43-0c1f6a1d0002"
* author.display = "María Laura Gómez Perez"

* title = "Resumen Internacional del Paciente - Chile"

* section[sectionImmunizaciones].title = "Inmunizaciones"
* section[sectionImmunizaciones].code = LNC#11369-6 "History of Immunization note"
* section[sectionImmunizaciones].text.status = #generated
* section[sectionImmunizaciones].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Registro mínimo de inmunización.</div>"
* section[sectionImmunizaciones].entry[0].reference = "urn:uuid:5e1c2f0a-7b0d-4c55-9a43-0c1f6a1d0003"
* section[sectionImmunizaciones].entry[0].display = "Inmunización COVID-19 registrada"

* section[sectionProblemas].title = "Problemas y condiciones"
* section[sectionProblemas].code = LNC#11450-4 "Problem list - Reported"
* section[sectionProblemas].text.status = #generated
* section[sectionProblemas].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Condición clínica registrada.</div>"
* section[sectionProblemas].entry[0].reference = "urn:uuid:5e1c2f0a-7b0d-4c55-9a43-0c1f6a1d0004"

* section[sectionMedicamentos].title = "Medicación"
* section[sectionMedicamentos].code = LNC#10160-0 "History of Medication use Narrative"
* section[sectionMedicamentos].text.status = #generated
* section[sectionMedicamentos].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Medicación activa registrada.</div>"
* section[sectionMedicamentos].entry[0].reference = "urn:uuid:5e1c2f0a-7b0d-4c55-9a43-0c1f6a1d0005"

* section[sectionAlergias].title = "Alergias e intolerancias"
* section[sectionAlergias].code = LNC#48765-2 "Allergies and adverse reactions Document"
* section[sectionAlergias].text.status = #generated
* section[sectionAlergias].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Alergia registrada.</div>"
* section[sectionAlergias].entry[0].reference = "urn:uuid:5e1c2f0a-7b0d-4c55-9a43-0c1f6a1d0006"


// =====================================================
// Recurso: Inmunización
// =====================================================
Instance: InmunizacionArg-Inline
InstanceOf: InmunizacionClIps
Usage: #inline

* id = "inmunizacion-1"
* status = #completed

* vaccineCode = CVX#207 "COVID-19, mRNA, LNP-S, PF, 100 mcg/0.5mL dose or 50 mcg/0.25mL dose"

* patient.reference = "urn:uuid:991a7102-d221-498d-9157-c4192934e3b7"
* patient.display = "Pablo Fernandez Perez"

* occurrenceDateTime = "2024-05-10"
* primarySource = true

// En InmunizacionArg, location.reference está restringido a 0..0.
// Se usa location.identifier.
* location.identifier.system = "https://vacunas.minsal.cl"
* location.identifier.value = "REFES-0001"
* location.display = "Centro de Salud de Ejemplo"

* lotNumber = "L240510A"

* reasonCode.text = "Calendario nacional de vacunación"

* protocolApplied[0].doseNumberPositiveInt = 1


// =====================================================
// Recurso: Condición IPS
// =====================================================
Instance: CondicionIps-Inline
InstanceOf: ConditionClIps
Usage: #inline

* id = "condicion-1"

* clinicalStatus = CondClinical#active "Active"
* verificationStatus = CondVerStatus#confirmed "Confirmed"

* code = SCT#38341003 "Hypertensive disorder, systemic arterial"
* subject.reference = "urn:uuid:991a7102-d221-498d-9157-c4192934e3b7"
* subject.display = "Pablo Fernandez Perez"

* onsetDateTime = "2020-01-01"


// =====================================================
// Recurso: MedicationStatement IPS
// =====================================================
Instance: MedicacionIps-Inline
InstanceOf: RegMedicamentosClIps
Usage: #inline

* id = "medicacion-1"

* status = #active
* medicationCodeableConcept.text = "Amlodipina 5 mg comprimido"
* subject.reference = "urn:uuid:991a7102-d221-498d-9157-c4192934e3b7"
* subject.display = "Pablo Fernandez Perez"

* effectiveDateTime = "2026-07-06"


// =====================================================
// Recurso: AllergyIntolerance IPS
// =====================================================
Instance: AlergiaIps-Inline
InstanceOf: AlergiaIntClIps
Usage: #inline

* id = "alergia-1"

* clinicalStatus = AllClinical#active "Active"
* verificationStatus = AllVerStatus#confirmed "Confirmed"

* code = SCT#91936005 "Allergy to penicillin"
* patient.reference = "urn:uuid:991a7102-d221-498d-9157-c4192934e3b7"
* patient.display = "Pablo Fernandez Perez"

* onsetDateTime = "2018-03-15"