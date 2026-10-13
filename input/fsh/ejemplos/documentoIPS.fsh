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


Instance: referenciaDocEjemplo
InstanceOf: DocumentoArg
Usage: #inline
Title: "Documento IPS Argentino mínimo con recursos inline"
Description: "Composition DocumentoArg con paciente externo y recursos clínicos contenidos."

// Recursos contenidos en la Composition.
// No se incluye el paciente, porque se referencia externamente.
* contained[0] = InmunizacionArg-Inline
* contained[1] = CondicionIps-Inline
* contained[2] = MedicacionIps-Inline
* contained[3] = AlergiaIps-Inline

* identifier.system = "http://hsisalud.org/documentos"
* identifier.value = "DOC-IPS-ARG-0001"

* status = #final
* type = LNC#60591-5 "Patient summary Document"

* subject = Reference(Paciente-Interno)
* subject.display = "Paciente argentino de ejemplo"

* date = "2026-07-06T10:30:00-03:00"

// El perfil restringe author.reference a 0..0.
// Por eso se usa una referencia lógica por identifier.
* author.identifier.system = "http://refes.msal.gob.ar"
* author.identifier.value = "REFEPS-123456"
* author.display = "Dra. Ana Ejemplo"

* title = "Resumen Internacional del Paciente - Argentina"

// -----------------------------
// Sección: Inmunizaciones
// -----------------------------
* section[sectionImmunizationsAR].title = "Inmunizaciones"
* section[sectionImmunizationsAR].code = LNC#11369-6 "History of Immunization Narrative"
* section[sectionImmunizationsAR].text.status = #generated
* section[sectionImmunizationsAR].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Registro mínimo de inmunización.</div>"
* section[sectionImmunizationsAR].entry[0].reference = #inmunizacion-1
* section[sectionImmunizationsAR].entry[0].display = "Inmunización COVID-19 registrada"

// -----------------------------
// Sección: Condiciones
// -----------------------------
* section[sectionConditionsAR].title = "Problemas y condiciones"
* section[sectionConditionsAR].code = LNC#11450-4 "Problem list - Reported"
* section[sectionConditionsAR].text.status = #generated
* section[sectionConditionsAR].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Condición clínica registrada.</div>"
* section[sectionConditionsAR].entry[0].reference = #condicion-1

// -----------------------------
// Sección: Medicación
// -----------------------------
* section[sectionMedicationAR].title = "Medicación"
* section[sectionMedicationAR].code = LNC#10160-0 "History of Medication use Narrative"
* section[sectionMedicationAR].text.status = #generated
* section[sectionMedicationAR].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Medicación activa registrada.</div>"
* section[sectionMedicationAR].entry[0].reference = #medicacion-1

// -----------------------------
// Sección: Alergias
// -----------------------------
* section[sectionAllergiesAR].title = "Alergias e intolerancias"
* section[sectionAllergiesAR].code = LNC#48765-2 "Allergies and adverse reactions Document"
* section[sectionAllergiesAR].text.status = #generated
* section[sectionAllergiesAR].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">Alergia registrada.</div>"
* section[sectionAllergiesAR].entry[0].reference = #alergia-1


// =====================================================
// Recurso contenido: Inmunización
// =====================================================
Instance: InmunizacionArg-Inline
InstanceOf: InmunizacionArg
Usage: #inline

* id = "inmunizacion-1"
* status = #completed

* vaccineCode = CVX#207 "COVID-19, mRNA, LNP-S, PF, 30 mcg/0.3 mL dose"

* patient = Reference(Paciente-Interno)
* patient.identifier.system = "http://www.renaper.gob.ar/dni"
* patient.identifier.value = "12345678"

* occurrenceDateTime = "2024-05-10"
* primarySource = true

// En InmunizacionArg, location.reference está restringido a 0..0.
// Se usa location.identifier.
* location.identifier.system = "http://refes.msal.gob.ar"
* location.identifier.value = "REFES-0001"
* location.display = "Centro de Salud de Ejemplo"

* lotNumber = "L240510A"

* reasonCode.text = "Calendario nacional de vacunación"

* protocolApplied[0].doseNumberPositiveInt = 1


// =====================================================
// Recurso contenido: Condición IPS
// =====================================================
Instance: CondicionIps-Inline
InstanceOf: ConditionUvIps
Usage: #inline

* id = "condicion-1"

* clinicalStatus = CondClinical#active "Active"
* verificationStatus = CondVerStatus#confirmed "Confirmed"

* code = SCT#38341003 "Hypertensive disorder, systemic arterial"
* subject = Reference(Paciente-Interno)
* subject.display = "Paciente argentino de ejemplo"

* onsetDateTime = "2020-01-01"


// =====================================================
// Recurso contenido: MedicationStatement IPS
// =====================================================
Instance: MedicacionIps-Inline
InstanceOf: MedicationStatementUvIps
Usage: #inline

* id = "medicacion-1"

* status = #active
* medicationCodeableConcept.text = "Amlodipina 5 mg comprimido"
* subject = Reference(Paciente-Interno)
* subject.display = "Paciente argentino de ejemplo"

* effectiveDateTime = "2026-07-06"


// =====================================================
// Recurso contenido: AllergyIntolerance IPS
// =====================================================
Instance: AlergiaIps-Inline
InstanceOf: AllergyIntoleranceUvIps
Usage: #inline

* id = "alergia-1"

* clinicalStatus = AllClinical#active "Active"
* verificationStatus = AllVerStatus#confirmed "Confirmed"

* code = SCT#91936005 "Allergy to penicillin"
* patient = Reference(Paciente-Interno)
* patient.display = "Paciente argentino de ejemplo"

* onsetDateTime = "2018-03-15"