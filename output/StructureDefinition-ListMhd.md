# FHIR.MHDIG\ListMhd - FHIR v4.0.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **ListMhd**

## Resource Profile: ListMhd 

| | |
| :--- | :--- |
| *Official URL*:http://mhd.ri.hsisalud.org/StructureDefinition/ListMhd | *Version*:0.3.0 |
| Draft as of 2026-09-02 | *Computable Name*:ListMhd |

 
Perfil asociado al listado de documentos referenciados para HSI en un modelo MHD 

**Usages:**

* Use this Profile: [BundleMhd](StructureDefinition-BundleMhd.md)
* Examples for this Profile: [List/EjemploListMhd](List-EjemploListMhd.md)
* CapabilityStatements using this Profile: [Capacidades para Cliente MHD](CapabilityStatement-MHDCliente.md) and [MHD Responder](CapabilityStatement-MHDResponder.md)

You can also check for [usages in the FHIR IG Statistics](https://packages2.fhir.org/xig/resource/fhir.mhdig|current/StructureDefinition/StructureDefinition-ListMhd.json)

### Formal Views of Profile Content

 [Description of Profiles, Differentials, Snapshots and how the different presentations work](http://build.fhir.org/ig/FHIR/ig-guidance/readingIgs.html#structure-definitions). 

 

Other representations of profile: [CSV](StructureDefinition-ListMhd.csv), [Excel](StructureDefinition-ListMhd.xlsx), [Schematron](StructureDefinition-ListMhd.sch) 



## Resource Content

```json
{
  "resourceType" : "StructureDefinition",
  "id" : "ListMhd",
  "url" : "http://mhd.ri.hsisalud.org/StructureDefinition/ListMhd",
  "version" : "0.3.0",
  "name" : "ListMhd",
  "status" : "draft",
  "date" : "2026-09-02T10:42:41-04:00",
  "publisher" : "HSI Pladema",
  "contact" : [{
    "name" : "HSI Pladema",
    "telecom" : [{
      "system" : "url",
      "value" : "https://hsi.pladema.net"
    }]
  }],
  "description" : "Perfil asociado al listado de documentos referenciados para HSI en un modelo MHD",
  "jurisdiction" : [{
    "coding" : [{
      "system" : "urn:iso:std:iso:3166",
      "code" : "AR",
      "display" : "Argentina"
    }]
  }],
  "fhirVersion" : "4.0.1",
  "mapping" : [{
    "identity" : "SubmissionSet-Mapping",
    "uri" : "XDS",
    "name" : "XDS and MHD Mapping"
  },
  {
    "identity" : "rim",
    "uri" : "http://hl7.org/v3",
    "name" : "RIM Mapping"
  },
  {
    "identity" : "w5",
    "uri" : "http://hl7.org/fhir/fivews",
    "name" : "FiveWs Pattern Mapping"
  }],
  "kind" : "resource",
  "abstract" : false,
  "type" : "List",
  "baseDefinition" : "https://profiles.ihe.net/ITI/MHD/StructureDefinition/IHE.MHD.Minimal.SubmissionSet",
  "derivation" : "constraint",
  "differential" : {
    "element" : [{
      "id" : "List.subject",
      "path" : "List.subject",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://ips.ri.hsisalud.org/StructureDefinition/PacienteArg"]
      }]
    },
    {
      "id" : "List.entry.item",
      "path" : "List.entry.item",
      "type" : [{
        "code" : "Reference",
        "targetProfile" : ["http://mhd.ri.hsisalud.org/StructureDefinition/ReferenciaDocumental"]
      }]
    }]
  }
}

```
