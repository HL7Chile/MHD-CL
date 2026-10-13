# FHIR.MHDIG\Ejemplo mínimo de List MHD - FHIR v4.0.1

* [**Table of Contents**](toc.md)
* [**Artifacts Summary**](artifacts.md)
* **Ejemplo mínimo de List MHD**

## Example List: Ejemplo mínimo de List MHD

Profile: [ListMhd](StructureDefinition-ListMhd.md)

| | | | |
| :--- | :--- | :--- | :--- |
| Date: 2026-07-06 | Mode: Working List | Status: Current | Code: SubmissionSet as a FHIR List |
| Subject:[Paciente argentino de ejemplo](Bundle-bundle-mhd-referencia-documental-ejemplo.md#urn-uuid-991a7102-d221-498d-9157-c4192934e3b7) | | | |

* **Items**: [Referencia documental de ejemplo](Bundle-bundle-mhd-referencia-documental-ejemplo.md#urn-uuid-32ab6cfe-8cdf-4c75-a831-47be8b5668fa)



## Resource Content

```json
{
  "resourceType" : "List",
  "id" : "EjemploListMhd",
  "meta" : {
    "profile" : ["http://mhd.ri.hsisalud.org/StructureDefinition/ListMhd"]
  },
  "extension" : [{
    "url" : "https://profiles.ihe.net/ITI/MHD/StructureDefinition/ihe-sourceId",
    "valueIdentifier" : {
      "system" : "urn:ietf:rfc:3986",
      "value" : "urn:oid:2.16.840.1.113883.3.9999.1"
    }
  }],
  "status" : "current",
  "mode" : "working",
  "code" : {
    "coding" : [{
      "system" : "https://profiles.ihe.net/ITI/MHD/CodeSystem/MHDlistTypes",
      "code" : "submissionset"
    }]
  },
  "subject" : {
    "reference" : "urn:uuid:991a7102-d221-498d-9157-c4192934e3b7",
    "display" : "Paciente argentino de ejemplo"
  },
  "date" : "2026-07-06",
  "entry" : [{
    "item" : {
      "reference" : "urn:uuid:32ab6cfe-8cdf-4c75-a831-47be8b5668fa",
      "display" : "Referencia documental de ejemplo"
    }
  }]
}

```
