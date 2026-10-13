Alias: $loinc = http://loinc.org

ValueSet: VSCategoriaDoc
Id: VSCategoriaDoc
Title: "Categorías de Documento Clínico para DocumentReference"
Description: "Categorías generales de documentos clínicos codificadas en LOINC para ser usadas en DocumentReference.category."
* ^status = #active
* ^experimental = false
* ^publisher = "HSI Pladema"
* ^jurisdiction = urn:iso:std:iso:3166#AR "Argentina"

* include $loinc#26436-6 "Laboratory studies (set)"
* include $loinc#18726-0 "Radiology studies (set)"
* include $loinc#11506-3 "Progress note"
* include $loinc#18842-5 "Discharge summary"
* include $loinc#60591-5 "Patient summary document"



ValueSet: VSTipoDocumento
Id: VSTipoDocumento
Title: "Tipos de Documento Clínico para DocumentReference"
Description: "Tipos documentales clínicos codificados en LOINC para ser usados en DocumentReference.type."
* ^status = #active
* ^experimental = false
* ^publisher = "HSI Pladema"
* ^jurisdiction = urn:iso:std:iso:3166#AR "Argentina"

* include $loinc#11502-2 "Laboratory report"
* include $loinc#18748-4 "Diagnostic imaging study"
* include $loinc#34131-3 "Outpatient Progress note"
* include $loinc#34105-7 "Hospital Discharge summary"
* include $loinc#59258-4 "Emergency department Discharge summary"
* include $loinc#34133-9 "Summary of episode note"