Instance: MHDResponder
InstanceOf: CapabilityStatement
Usage: #definition
Title: "MHD Responder"
Description: """
CapabilityStatement que define las capacidades requeridas para un servidor
MHD conforme a la Guía MHD para HSI.

El servidor implementa las funciones de Document Recipient y Document
Responder definidas por IHE MHD 4.2.2, adaptadas a los perfiles locales
de esta guía.
"""

* publisher = "HSI Pladema"
* contact[0].name = "HSI Pladema"
* contact[0].telecom.system = #url
* contact[0].telecom.value = "https://hsi.pladema.net"
* jurisdiction = urn:iso:std:iso:3166#AR


* url = "http://mhd.ri.hsisalud.org/CapabilityStatement/MHDResponder"

* name = "MHDResponder"
* title = "MHD Responder"

* status = #draft
* experimental = false
* date = "2026-09-02"

* publisher = "HSI Pladema"

* kind = #requirements

* instantiates[0] = "https://profiles.ihe.net/ITI/MHD/CapabilityStatement/IHE.MHD.DocumentRecipient"
* instantiates[+] = "https://profiles.ihe.net/ITI/MHD/CapabilityStatement/IHE.MHD.DocumentResponder"

* implementationGuide = "http://mhd.ri.hsisalud.org/ImplementationGuide/fhir.mhdig"

* fhirVersion = #4.0.1

* format[0] = #"application/fhir+json"
* format[+] = #"application/fhir+xml"


// =====================================================
// SERVIDOR
// =====================================================

* rest.mode = #server

* rest.documentation = """
Servidor MHD local que permite registrar, consultar y recuperar
documentos clínicos utilizando las transacciones definidas por
IHE MHD y los perfiles definidos por esta guía.
"""

* rest.security.description = """
Las transacciones deben realizarse mediante HTTPS y aplicar los
mecanismos de autenticación, autorización, control de acceso,
auditoría y trazabilidad definidos para la infraestructura.
"""


// =====================================================
// ITI-65 - PROVIDE DOCUMENT BUNDLE
// =====================================================

* rest.interaction[0].code = #transaction
* rest.interaction[0].documentation = """
ITI-65 Provide Document Bundle.

El servidor SHALL aceptar un Bundle transaction conforme al perfil
BundleMhd:

http://mhd.ri.hsisalud.org/StructureDefinition/BundleMhd
"""


// =====================================================
// BÚSQUEDA A NIVEL DE SISTEMA
// =====================================================

* rest.interaction[+].code = #search-system
* rest.interaction[=].documentation = """
Búsqueda a nivel de sistema de acuerdo con las capacidades
definidas para IHE MHD Document Responder.
"""


// =====================================================
// DOCUMENTREFERENCE
// ITI-67 - FIND DOCUMENT REFERENCES
// =====================================================

* rest.resource[0].type = #DocumentReference

* rest.resource[0].profile =
    "http://mhd.ri.hsisalud.org/StructureDefinition/ReferenciaDocumental"

* rest.resource[0].interaction[0].code = #read
* rest.resource[0].interaction[+].code = #search-type

* rest.resource[0].interaction[=].documentation = """
ITI-67 Find Document References.
Permite localizar referencias documentales mediante los parámetros
de búsqueda definidos por IHE MHD y esta guía.
"""


// -----------------------------------------------------
// Parámetros de búsqueda DocumentReference
// -----------------------------------------------------

* rest.resource[0].searchParam[0].name = "_id"
* rest.resource[0].searchParam[0].type = #token

* rest.resource[0].searchParam[+].name = "_lastupdated"
* rest.resource[0].searchParam[=].type = #date

* rest.resource[0].searchParam[+].name = "author.given"
* rest.resource[0].searchParam[=].type = #string

* rest.resource[0].searchParam[+].name = "author.family"
* rest.resource[0].searchParam[=].type = #string

* rest.resource[0].searchParam[+].name = "category"
* rest.resource[0].searchParam[=].type = #token

* rest.resource[0].searchParam[+].name = "creation"
* rest.resource[0].searchParam[=].type = #date

* rest.resource[0].searchParam[+].name = "date"
* rest.resource[0].searchParam[=].type = #date

* rest.resource[0].searchParam[+].name = "event"
* rest.resource[0].searchParam[=].type = #token

* rest.resource[0].searchParam[+].name = "facility"
* rest.resource[0].searchParam[=].type = #token

* rest.resource[0].searchParam[+].name = "format"
* rest.resource[0].searchParam[=].type = #token

* rest.resource[0].searchParam[+].name = "identifier"
* rest.resource[0].searchParam[=].type = #token

* rest.resource[0].searchParam[+].name = "patient"
* rest.resource[0].searchParam[=].type = #reference

* rest.resource[0].searchParam[+].name = "patient.identifier"
* rest.resource[0].searchParam[=].type = #token

* rest.resource[0].searchParam[+].name = "period"
* rest.resource[0].searchParam[=].type = #date

* rest.resource[0].searchParam[+].name = "related"
* rest.resource[0].searchParam[=].type = #reference

* rest.resource[0].searchParam[+].name = "security-label"
* rest.resource[0].searchParam[=].type = #token

* rest.resource[0].searchParam[+].name = "setting"
* rest.resource[0].searchParam[=].type = #token

* rest.resource[0].searchParam[+].name = "status"
* rest.resource[0].searchParam[=].type = #token

* rest.resource[0].searchParam[+].name = "type"
* rest.resource[0].searchParam[=].type = #token


// =====================================================
// LIST
// ITI-66 - FIND DOCUMENT LISTS
// =====================================================

* rest.resource[1].type = #List

* rest.resource[1].profile =
    "http://mhd.ri.hsisalud.org/StructureDefinition/ListMhd"

* rest.resource[1].interaction[0].code = #read
* rest.resource[1].interaction[+].code = #search-type

* rest.resource[1].interaction[=].documentation = """
ITI-66 Find Document Lists.
Permite consultar los SubmissionSet registrados utilizando
el perfil ListMhd.
"""

* rest.resource[1].searchParam[0].name = "_id"
* rest.resource[1].searchParam[0].type = #token

* rest.resource[1].searchParam[+].name = "_lastupdated"
* rest.resource[1].searchParam[=].type = #date

* rest.resource[1].searchParam[+].name = "code"
* rest.resource[1].searchParam[=].type = #token

* rest.resource[1].searchParam[+].name = "date"
* rest.resource[1].searchParam[=].type = #date

* rest.resource[1].searchParam[+].name = "identifier"
* rest.resource[1].searchParam[=].type = #token

* rest.resource[1].searchParam[+].name = "patient"
* rest.resource[1].searchParam[=].type = #reference

* rest.resource[1].searchParam[+].name = "patient.identifier"
* rest.resource[1].searchParam[=].type = #token

* rest.resource[1].searchParam[+].name = "source.given"
* rest.resource[1].searchParam[=].type = #string

* rest.resource[1].searchParam[+].name = "source.family"
* rest.resource[1].searchParam[=].type = #string

* rest.resource[1].searchParam[+].name = "status"
* rest.resource[1].searchParam[=].type = #token

* rest.resource[1].searchParam[+].name = "designationType"
* rest.resource[1].searchParam[=].type = #token

* rest.resource[1].searchParam[+].name = "sourceId"
* rest.resource[1].searchParam[=].type = #token