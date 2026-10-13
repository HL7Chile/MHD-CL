Instance: MHDCliente
InstanceOf: CapabilityStatement
Usage: #definition
Title: "Capacidades para Cliente MHD"
Description: """
CapabilityStatement que define las capacidades requeridas para los
sistemas cliente que interactúan con el MHD Responder definido por
esta guía.

El cliente implementa las funciones de Document Source y Document
Consumer definidas por IHE MHD 4.2.2, adaptadas a los perfiles y
restricciones de esta implementación local.

El cliente puede publicar documentos mediante ITI-65, consultar
SubmissionSets mediante ITI-66, localizar referencias documentales
mediante ITI-67 y recuperar documentos mediante ITI-68.
"""
* publisher = "HSI Pladema"
* contact[0].name = "HSI Pladema"
* contact[0].telecom.system = #url
* contact[0].telecom.value = "https://hsi.pladema.net"
* jurisdiction = urn:iso:std:iso:3166#AR



* url = "http://mhd.ri.hsisalud.org/CapabilityStatement/MHDCliente"



* name = "MHDCliente"

* title = "Capacidades para Cliente MHD"

* status = #draft

* experimental = false
* date = "2026-09-02"

* kind = #requirements

* fhirVersion = #4.0.1

* format[0] = #"application/fhir+json"
* format[+] = #"application/fhir+xml"


// =====================================================
// CONFORMIDAD CON IHE MHD
// =====================================================

* instantiates[0] =
    "https://profiles.ihe.net/ITI/MHD/CapabilityStatement/IHE.MHD.DocumentSource"

* instantiates[+] =
    "https://profiles.ihe.net/ITI/MHD/CapabilityStatement/IHE.MHD.DocumentConsumer"


// =====================================================
// IMPLEMENTATION GUIDE
// =====================================================

* implementationGuide =
    "http://mhd.ri.hsisalud.org/ImplementationGuide/fhir.mhdig"


// =====================================================
// CLIENTE
// =====================================================

* rest.mode = #client

* rest.documentation = """
Cliente MHD local que permite publicar, localizar y recuperar
documentos clínicos mediante las transacciones definidas por
IHE MHD y los perfiles definidos por esta guía.
"""

* rest.security.description = """
Las comunicaciones deben realizarse mediante HTTPS y utilizar
los mecanismos de autenticación, autorización, control de acceso,
auditoría y trazabilidad definidos para la infraestructura local.
"""


// =====================================================
// ITI-65 - PROVIDE DOCUMENT BUNDLE
// Document Source
// =====================================================

* rest.interaction[0].code = #transaction

* rest.interaction[0].documentation = """
ITI-65 Provide Document Bundle.

El cliente SHALL poder generar y enviar un Bundle transaction
conforme al perfil BundleMhd definido por esta guía:

http://mhd.ri.hsisalud.org/StructureDefinition/BundleMhd
"""


// =====================================================
// BÚSQUEDA A NIVEL DE SISTEMA
// =====================================================

* rest.interaction[+].code = #search-system

* rest.interaction[=].documentation = """
El cliente puede realizar búsquedas a nivel de sistema conforme
a las capacidades definidas para el Document Consumer de IHE MHD.
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

El cliente SHALL poder buscar referencias documentales utilizando
los parámetros definidos por IHE MHD y las restricciones establecidas
por esta guía.
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

El cliente SHALL poder consultar SubmissionSets representados mediante
el recurso List y el perfil ListMhd definido por esta guía.
"""


// -----------------------------------------------------
// Parámetros de búsqueda List
// -----------------------------------------------------

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


// =====================================================
// ITI-68 - RETRIEVE DOCUMENT
// =====================================================

// NOTA:
// IHE MHD estándar declara Binary/read para ITI-68.
// En esta implementación local el documento puede ser recuperado
// utilizando DocumentReference.content.attachment.url.
//
// Si el servidor MHD local soporta además GET /Binary/{id},
// se debe habilitar el siguiente bloque:
//
// * rest.resource[2].type = #Binary
// * rest.resource[2].interaction[0].code = #read
//
// * rest.resource[2].interaction[0].documentation = """
// ITI-68 Retrieve Document.
// El cliente SHALL poder recuperar el contenido documental
// mediante la interacción read sobre Binary.
// """