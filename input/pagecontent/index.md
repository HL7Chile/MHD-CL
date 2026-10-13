# Guía de Implementación MHD

## Introducción

Esta Guía de Implementación define los requisitos para el intercambio de documentos clínicos mediante el estándar HL7® FHIR®, utilizando como base el perfil **Mobile access to Health Documents (MHD)** desarrollado por IHE.

La guía adapta los perfiles, actores y transacciones definidos por IHE MHD al contexto argentino, incorporando los requisitos nacionales de identificación de pacientes, profesionales y organizaciones establecidos por la **Guía de Implementación Core Argentina (Core AR)**.

Su propósito es facilitar el registro, consulta y recuperación interoperable de documentos clínicos entre sistemas de información de salud.

## Objetivo

El objetivo de esta guía es establecer una implementación común para:

- Registrar documentos clínicos y sus metadatos.
- Agrupar documentos dentro de un SubmissionSet.
- Consultar documentos utilizando parámetros normalizados.
- Recuperar documentos clínicos desde un repositorio.
- Identificar pacientes, profesionales y organizaciones de acuerdo con las definiciones nacionales.
- Facilitar la interoperabilidad entre sistemas clínicos, repositorios documentales y plataformas de intercambio de información sanitaria.

## Alcance

Esta guía cubre el intercambio de documentos clínicos mediante recursos FHIR, incluyendo principalmente:

- Registro de metadatos documentales.
- Registro de conjuntos de documentos.
- Consulta de referencias documentales.
- Recuperación de documentos.
- Asociación de los documentos con pacientes, profesionales y organizaciones.
- Uso de terminologías y sistemas de identificación nacionales.

El contenido clínico del documento se encontrará almacenado en un repositorio externo. En estos casos, el recurso `DocumentReference` contiene la URL necesaria para acceder al documento.

## Dependencias

Esta guía utiliza las siguientes Guías de Implementación como dependencias:

### IHE Mobile access to Health Documents (MHD)

IHE MHD proporciona los perfiles, actores y transacciones necesarios para compartir documentos clínicos utilizando recursos y operaciones FHIR.

Esta guía reutiliza y restringe los perfiles definidos por IHE MHD, principalmente:

- `DocumentReference` para representar los metadatos del documento.
- `List` para representar un SubmissionSet.
- `Bundle` de tipo `transaction` para registrar conjuntamente los recursos.
- Operaciones de búsqueda para consultar documentos y conjuntos documentales.
- Mecanismos de recuperación del contenido documental.

La implementación local mantiene la compatibilidad con las transacciones definidas por IHE MHD.

### Core Argentina (Core AR)

Core AR proporciona las definiciones nacionales utilizadas para representar las entidades fundamentales del sistema de salud argentino.

Esta guía utiliza perfiles y terminologías de Core AR para:

- Identificación de pacientes.
- Identificación de profesionales de salud.
- Identificación de organizaciones y establecimientos.
- Representación de datos demográficos.
- Uso de sistemas de identificación y terminologías nacionales.

Cuando un recurso definido por IHE MHD referencia a un paciente, profesional u organización, se deben utilizar los perfiles correspondientes definidos por Core AR, siempre que sean aplicables.

## Relación entre las guías

La relación entre las Guías de Implementación puede resumirse de la siguiente manera:

- **HL7 FHIR R4** proporciona el estándar base de interoperabilidad.
- **Core AR** define los requisitos nacionales para las entidades fundamentales.
- **IHE MHD** define el modelo internacional para el intercambio de documentos clínicos.
- **Esta guía** combina y restringe ambos conjuntos de definiciones para su aplicación en el contexto argentino.

```mermaid
flowchart TB
    FHIR["HL7 FHIR R4"]
    CORE["Core Argentina"]
    MHD["IHE MHD"]
    LOCAL["Guía MHD Argentina"]

    FHIR --> CORE
    FHIR --> MHD
    CORE --> LOCAL
    MHD --> LOCAL


Los requerimientos de conformidad establecen las funcionalidades esperadas para aplicaciones cliente y servidor, identificando los perfiles y las interacciones que deben implementar.

### Dependencias

{% include dependency-table.xhtml %}

### Parametros de Expansión

{% include expansion-params.xhtml %}

### Analisis de versiones cruzadas

{% include cross-version-analysis.xhtml %}

### Perfiles globales

{% include globals-table.xhtml %}

### Declaracion de propiedad intelectual

{% include ip-statements.xhtml %}


