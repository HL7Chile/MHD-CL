# FHIR.MHDIG\BundleMhd - FHIR v4.0.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **BundleMhd**

## Resource Profile: BundleMhd 

| | |
| :--- | :--- |
| *Official URL*:http://mhd.ri.hsisalud.org/StructureDefinition/BundleMhd | *Version*:0.3.0 |
| Draft as of 2026-06-22 | *Computable Name*:BundleMhd |

 
Perfil asociado al bundle de transacciones MHD, considerando la asociación de documentos de tipo IPS, referenciados a la Guía Core Argentna AR.FHIR.CORE 

**Usages:**

* Examples for this Profile: [Bundle/bundle-mhd-referencia-documental-ejemplo](Bundle-bundle-mhd-referencia-documental-ejemplo.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.mhdig|current/StructureDefinition/StructureDefinition-BundleMhd.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-BundleMhd.csv), [Excel](StructureDefinition-BundleMhd.xlsx), [Schematron](StructureDefinition-BundleMhd.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "BundleMhd",
  "url" : "http://mhd.ri.hsisalud.org/StructureDefinition/BundleMhd",
  "version" : "0.3.0",
  "name" : "BundleMhd",
  "status" : "draft",
  "date" : "2026-06-22",
  "publisher" : "HSI Pladema",
  "contact" : [{
    "name" : "HSI Pladema",
    "telecom" : [{
      "system" : "url",
      "value" : "https://hsi.pladema.net"
    }]
  }],
  "description" : "Perfil asociado al bundle de transacciones MHD, considerando la asociación de documentos de tipo IPS, referenciados a la Guía Core Argentna AR.FHIR.CORE",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "AR",
      "display" : "Argentina"
    }]
  }],
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "v2",
    "uri" : "http://hl7.org/v2",
    "name" : "HL7 v2 Mapping"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "cda",
    "uri" : "http://hl7.org/v3/cda",
    "name" : "CDA (R2)"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "Bundle",
  "baseDefinition" : "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Minimal.ProvideBundle",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "Bundle",
      "path" : "Bundle"
    },
    {
      "id" : "Bundle.meta.profile",
      "path" : "Bundle.meta.profile",
      "short" : "Perfil asociado al bundle de transacciones MHD",
      "definition" : "Perfil asociado al bundle de transacciones MHD, considerando la asociación de documentos de tipo IPS, referenciados a la Guía Core Argentna AR.FHIR.CORE",
      "example" : [{
        "label" : "Ejemplo de perfil asociado al bundle de transacciones MHD",
        "valueUri" : "http://mhd.ri.hsisalud.org/StructureDefinition/BundleMhd"
      }],
      "mustSupport" : true
    },
    {
      "id" : "Bundle.type",
      "path" : "Bundle.type",
      "short" : "document|transaction|batch|searchset|history|collection|message|event|parameters",
      "definition" : "Tipo de bundle asociado a transacciones MHD, considerando la asociación"
    },
    {
      "id" : "Bundle.entry:SubmissionSet",
      "path" : "Bundle.entry",
      "sliceName" : "SubmissionSet",
      "mustSupport" : true
    },
    {
      "id" : "Bundle.entry:SubmissionSet.resource",
      "path" : "Bundle.entry.resource",
      "type" : [{
        "code" : "List",
        "profile" : ["http://mhd.ri.hsisalud.org/StructureDefinition/ListMhd"]
      }]
    },
    {
      "id" : "Bundle.entry:SubmissionSet.request.url",
      "path" : "Bundle.entry.request.url",
      "patternUri" : "List"
    },
    {
      "id" : "Bundle.entry:DocumentRefs",
      "path" : "Bundle.entry",
      "sliceName" : "DocumentRefs",
      "mustSupport" : true
    },
    {
      "id" : "Bundle.entry:DocumentRefs.resource",
      "path" : "Bundle.entry.resource",
      "type" : [{
        "code" : "DocumentReference",
        "profile" : ["http://mhd.ri.hsisalud.org/StructureDefinition/ReferenciaDocumental"]
      }]
    },
    {
      "id" : "Bundle.entry:DocumentRefs.request.url",
      "path" : "Bundle.entry.request.url",
      "patternUri" : "/DocumentReference"
    },
    {
      "id" : "Bundle.entry:UpdateDocumentRefs",
      "path" : "Bundle.entry",
      "sliceName" : "UpdateDocumentRefs",
      "mustSupport" : true
    },
    {
      "id" : "Bundle.entry:Documents",
      "path" : "Bundle.entry",
      "sliceName" : "Documents",
      "mustSupport" : true
    },
    {
      "id" : "Bundle.entry:FhirDocuments",
      "path" : "Bundle.entry",
      "sliceName" : "FhirDocuments",
      "mustSupport" : true
    },
    {
      "id" : "Bundle.entry:FhirDocuments.resource",
      "path" : "Bundle.entry.resource",
      "type" : [{
        "code" : "Bundle",
        "profile" : ["http://ips.ri.hsisalud.org/StructureDefinition/BundleDocArg"]
      }]
    },
    {
      "id" : "Bundle.entry:FhirDocuments.request.url",
      "path" : "Bundle.entry.request.url",
      "patternUri" : "Bundle"
    },
    {
      "id" : "Bundle.entry:Folders",
      "path" : "Bundle.entry",
      "sliceName" : "Folders",
      "mustSupport" : true
    },
    {
      "id" : "Bundle.entry:Patient",
      "path" : "Bundle.entry",
      "sliceName" : "Patient",
      "mustSupport" : true
    },
    {
      "id" : "Bundle.entry:Patient.resource",
      "path" : "Bundle.entry.resource",
      "type" : [{
        "code" : "Patient",
        "profile" : ["http://ips.ri.hsisalud.org/StructureDefinition/PacienteArg"]
      }]
    },
    {
      "id" : "Bundle.entry:Patient.request.method",
      "path" : "Bundle.entry.request.method",
      "short" : "GET|POST|PUT|DELETE|PATCH"
    },
    {
      "id" : "Bundle.entry:Patient.request.url",
      "path" : "Bundle.entry.request.url",
      "patternUri" : "Patient"
    }]
  }
}

```
