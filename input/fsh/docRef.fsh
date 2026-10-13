
// This is a simple example of a FSH file.
// This file can be renamed, and additional FSH files can be added.
// SUSHI will look for definitions in any file using the .fsh ending.
Profile: ReferenciaDocumental
Id: ReferenciaDocumental
Parent: MinimalDocumentReference
Description: "Perfil asociado al la refetrencia documental para HSI en un modelo MHD, consderado para transacciones asociadas a una ITI-65 e ITI-67. Se considera en el perfil la asociación de documentos de tipo IPS, referenciados a la Guía Core Argentna AR.FHIR.CORE"

* ^status = #draft
* ^publisher = "HSI Pladema"
* ^contact.name = "HSI Pladema"
* ^contact.telecom.system = #url
* ^contact.telecom.value = "https://hsi.pladema.net"
* ^jurisdiction = urn:iso:std:iso:3166#AR


* masterIdentifier 1..1 MS
  * ^short = "Identificador único para el documento IPS nacional referenciado. Es el identificador principal del IPS"
  * ^definition = "Identificador único para el documento IPS nacional referenciado. Se define como el identificador principal del docunento, el cual debe ser un identificador absoluto, único e irrepetible en el domino en donde ha sido almacenado"
  * ^example[0].label = "Ejemplo de identificador maestro"
  * ^example[0].valueIdentifier.system = "https://repositorio.cl/documentos/ips"
  * ^example[0].valueIdentifier.value = "IPS-2026-00001"
 

* identifier 0..* MS
  * ^short = "Identificador alternativo para el documento IPS nacional referenciado. Es un identificador secundario del IPS"
  * ^definition = "Identificador alternativo para el documento IPS nacional referenciado. Se usa comunmente cuando el document se ha almacenado en varios dominios, y cada uno de ellos le ha asignado un identificador diferente."
* identifier[entryUUID] MS
* status 1..1 MS
  * ^short = "Estado de la referencia al documento IPS: current|superseded|entered-in-error"
  * ^definition = "Estado de la referncia. Se define como un campo obligatorio, y se recomienda usar el valor 'current' para indicar que el documento referenciado es el más actualizado de los disponibles."
* status from https://profiles.ihe.net/ITI/MHD/ValueSet/DocumentReferenceStats

* type 1..1 MS
  * ^short = "Tipo de documento  referenciado"
  * ^definition = "Tipo de documento  referenciado. Se define como un campo obligatorio. Puede ser un Resumen, o un Informe de Examen o un Informe de Alta, o una Nota médca u otro"
* type from VSTipoDocumento (extensible)
  * coding
    * system 
      * ^example[0].label = "Para IPS"
      * ^example[0].valueUri =  "http://loinc.org"
    * code 
      * ^example[0].label = "Código Loinc para IPS"
      * ^example[0].valueCode =  #34133-9 
    * display 
      * ^example[0].label = "El display asociado"
      * ^example[0].valueString =  "Summary of episode note"


* category 1..1 MS
  * ^short = "Categoría del documento referenciado"
  * ^definition = "Categoría del documento referenciado. Se define como un campo obligatorio (Resumen de Historia, Examen de Laboratiro, Informe de Imagenología, Alta de Hospitalizado, etc), se usa LOINC para estos códigos."
  * coding 
    * system 
      * ^example[0].label = "Para IPS"
      * ^example[0].valueUri =  "http://loinc.org"
    * code 
      * ^example[0].label = "Loinc Asociado"
      * ^example[0].valueCode =  #60591-5
    
    * display 
      * ^example[0].label = "Display asociado al código Loinc"
      * ^example[0].valueString =  "Patient summary Document"
  * text = "Resumen clínico de paciente"
* category from VSCategoriaDoc (extensible)

* subject 1..1 MS
  * ^short = "Paciente al que se refiere el documento IPS nacional referenciado"
  * ^definition = "Paciente al que se refiere el documento IPS nacional referenciado. Se define como un campo obligatorio, y se recomienda usar el valor 'Patient' para indicar que el documento referenciado es un informe clínico de un paciente."
* subject only Reference(PacienteArg)
  
 

* date 1..1 MS
  * ^short = "Fecha de creación del documento IPS nacional referenciado"
  * ^definition = "Fecha de creación del documento IPS nacional referenciado. Se define como un campo obligatorio, y se recomienda usar el valor 'dateTime' para indicar la fecha de creación del documento referenciado."

* author 1..* MS
  * ^short = "Autor del documento o IPS nacional referenciado"
  * ^definition = "Autor del documento o IPS nacional referenciado. Se define como un campo opcional, y se recomienda usar el valor 'Practitioner' para indicar que el autor del documento referenciado es un profesional de la salud."

* securityLabel 0..* MS
  * ^short = "Etiqueta de seguridad del documento IPS nacional referenciado"
  * ^definition = "Etiqueta de seguridad del documento IPS nacional referenciado. Se define como un campo opcional, y se recomienda usar el valor 'CodeableConcept' para indicar la etiqueta de seguridad del documento referenciado."

* content 1..1 MS

  * ^short = "Contenido del documento (IPS u otro) nacional referenciado con url reltiva en caso de ser X-Road, o url absoluta en caso de ser un repositorio FHIR. Se define como un campo obligatorio, y se recomienda usar el valor 'Attachment' para indicar que el contenido del documento referenciado es un archivo adjunto que contiene el documento clínico en formato digital."
  * ^definition = "Contenido del documento (IPS u otro) nacional referenciado con url referencial. Se define como un campo obligatorio, y se recomienda usar el valor 'Attachment' para indicar que el contenido del documento referenciado es un archivo adjunto que contiene el documento clínico en formato digital."
  * attachment 1..1 MS
    * ^short = "Definición del archivo adjunto que contiene el documento referenciado"
    * ^definition = "Definición del archivo adjunto que contiene el documento (IPS u otro) nacional referenciado. Se define como un campo obligatorio, y se recomienda usar el valor 'Attachment' para indicar que el contenido del documento referenciado es un archivo adjunto que contiene el documento clínico en formato digital."
    * contentType 1..1 MS
    * contentType = #application/fhir+json        
    * url 1..1 MS
      * ^short = "URL del archivo adjunto que contiene el documento  referenciado, en formato FHIR IPS, Binary IPS u otro documnento en esos formatos."
      * ^definition = "URL del archivo adjunto que contiene el documento (IPS u otro) nacional referenciado puede ser un binary o un Bundle tipo document"
      * ^example[0].label = "Ejemplo de IPS referenciado en X-Road"
      * ^example[0].valueUrl =  "/pba/tndXroad/santamarina/docs/ips-xxx"
      
    * hash 0..1 MS
      * ^short = "Hash del archivo adjunto que contiene el documento IPS nacional referenciado"
      * ^definition = "Hash del archivo adjunto que contiene el documento (IPS u otro) nacional referenciado. Se define como un campo obligatorio, y se recomienda usar el valor 'base64Binary' para indicar el hash del archivo adjunto que contiene el documento clínico en formato digital."
    * title 0..1 MS
      * ^short = "Título del archivo adjunto que contiene el documento  referenciado"
      * ^definition = "Título del archivo adjunto que contiene el documento (IPS u otro) nacional referenciado. Se define como un campo opcional, y se recomienda usar el valor 'string' para indicar el título del archivo adjunto que contiene el documento clínico en formato digital."
      * ^example[0].label = "Ejemplo de Título del documento contenido referenciado via X-Road"
      * ^example[0].valueString =  "IPS-001"
/*
* content.extension contains ContentDoc  named ContentDoc 0..* MS
* content.extension[ContentDoc] ^short = "Extensiones del documento IPS nacional referenciado a Server FHIR"
* content.extension[ContentDoc] ^definition = "Extensiones del documento (IPS u otro) nacional referenciado. Se define como un campo opcional, y se recomienda usar el valor 'Extension' para indicar las extensiones del documento clínico referenciado."
* content.extension[ContentDoc].valueAttachment
  * contentType = #application/fhir+json
  * url
    * ^example[0].label = "Ejemplo de documento IPS referenciado en Repo FHIR, si fuera Binary sería /Binary/ips-xxx, si fuera un Bundle tipo document sería /Binary/ips-xxx"
    * ^example[0].valueUrl =  "/Bundle/ips-xxx"
*/
  
* context 1..1 MS
  * ^short = "Contexto del documento IPS nacional u otro referenciado"
  * ^definition = "Contexto del documento IPS nacional u otro referenciado. Se define como un campo opcional, y se recomienda usar el valor 'DocumentReference.context' para indicar el contexto del documento clínico referenciado."
  * period 0..1 MS
    * ^short = "Periodo de tiempo al que se refiere el documento IPS nacional u otro referenciado"
    * ^definition = "Periodo de tiempo al que se refiere el documento IPS nacional u otro referenciado. Se define como un campo opcional, y se recomienda usar el valor 'Period' para indicar el periodo de tiempo al que se refiere el documento clínico referenciado."
