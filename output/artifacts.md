# FHIR.MHDIG\Artifacts Summary - FHIR v4.0.1

* [**Table of Contents**](toc.md)
* **Artifacts Summary**

## Artifacts Summary

This page provides a list of the FHIR artifacts defined as part of this implementation guide.

### Behavior: Capability Statements 

The following artifacts define the specific capabilities that different types of systems are expected to have in order to comply with this implementation guide. Systems conforming to this implementation guide are expected to declare conformance to one or more of the following capability statements.

| | |
| :--- | :--- |
| [Capacidades para Cliente MHD](CapabilityStatement-MHDCliente.md) | CapabilityStatement que define las capacidades requeridas para los sistemas cliente que interactúan con el MHD Responder definido por esta guía.El cliente implementa las funciones de Document Source y Document Consumer definidas por IHE MHD 4.2.2, adaptadas a los perfiles y restricciones de esta implementación local.El cliente puede publicar documentos mediante ITI-65, consultar SubmissionSets mediante ITI-66, localizar referencias documentales mediante ITI-67 y recuperar documentos mediante ITI-68. |
| [MHD Responder](CapabilityStatement-MHDResponder.md) | CapabilityStatement que define las capacidades requeridas para un servidor MHD conforme a la Guía MHD para HSI.El servidor implementa las funciones de Document Recipient y Document Responder definidas por IHE MHD 4.2.2, adaptadas a los perfiles locales de esta guía. |

### Structures: Resource Profiles 

These define constraints on FHIR resources for systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [BundleMhd](StructureDefinition-BundleMhd.md) | Perfil asociado al bundle de transacciones MHD, considerando la asociación de documentos de tipo IPS, referenciados a la Guía Core Argentna AR.FHIR.CORE |
| [ListMhd](StructureDefinition-ListMhd.md) | Perfil asociado al listado de documentos referenciados para HSI en un modelo MHD |
| [ReferenciaDocumental](StructureDefinition-ReferenciaDocumental.md) | Perfil asociado al la refetrencia documental para HSI en un modelo MHD, consderado para transacciones asociadas a una ITI-65 e ITI-67. Se considera en el perfil la asociación de documentos de tipo IPS, referenciados a la Guía Core Argentna AR.FHIR.CORE |

### Terminology: Value Sets 

These define sets of codes used by systems conforming to this implementation guide.

| | |
| :--- | :--- |
| [Categorías de Documento Clínico para DocumentReference](ValueSet-VSCategoriaDoc.md) | Categorías generales de documentos clínicos codificadas en LOINC para ser usadas en DocumentReference.category. |
| [Tipos de Documento Clínico para DocumentReference](ValueSet-VSTipoDocumento.md) | Tipos documentales clínicos codificados en LOINC para ser usados en DocumentReference.type. |

### Example: Example Instances 

These are example instances that show what data produced and consumed by systems conforming with this implementation guide might look like.

| | |
| :--- | :--- |
| [Bundle MHD con referencia documental de ejemplo](Bundle-bundle-mhd-referencia-documental-ejemplo.md) | Bundle transaction que vincula el DocumentReference generado previamente. |
| [Ejemplo mínimo de List MHD](List-EjemploListMhd.md) | Ejemplo mínimo de List como SubmissionSet MHD con una referencia documental. |
| [Paciente-Interno](Patient-Paciente-Interno.md) | Ejemplo de paciente argentino conforme al perfil PacienteArg, con identificador de dominio y nombre legal. |
| [PrestadorArgInline](Practitioner-PrestadorArgInline.md) | Ejemplo inline de profesional argentino conforme al perfil PrestadorArg. |
| [Referencia documental mínima para DocumentoArg](DocumentReference-ReferDocEjemplo.md) | Ejemplo de DocumentReference MHD que referencia un documento clínico FHIR DocumentoArg. |

