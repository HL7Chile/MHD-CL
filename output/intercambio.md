# FHIR.MHDIG\Esquemas de transacciones FHIR MHD - FHIR v4.0.1

* [**Table of Contents**](toc.md)
* **Esquemas de transacciones FHIR MHD**

## Esquemas de transacciones FHIR MHD

# Arquitectura MHD para la publicación, búsqueda y recuperación de un documento IPS

## Introducción

La arquitectura presentada describe cómo utilizar el perfil **Mobile access to Health Documents (MHD)** de IHE para publicar, localizar y recuperar un **International Patient Summary (IPS)** representado mediante recursos HL7 FHIR.

El modelo separa dos tipos de información:

* Los **metadatos documentales**, utilizados para registrar, identificar y buscar el IPS.
* El **contenido clínico completo**, correspondiente al documento IPS propiamente tal.

Esta separación permite que un sistema consumidor primero busque los metadatos de los documentos disponibles y, posteriormente, recupere únicamente el documento que necesita.

La arquitectura considera tres actores principales:

1. **Document Source**, que produce y publica el IPS.
1. **MHD Responder**, que registra los metadatos y conserva el contenido recuperable.
1. **Document Consumer**, que busca y recupera el IPS para utilizarlo clínicamente.

## Visión general del proceso

El flujo completo se desarrolla en tres etapas:

1. El**Document Source**genera el IPS y lo publica mediante la transacción**ITI-65 Provide Document Bundle**.
1. El**Document Consumer**busca los metadatos del IPS mediante la transacción**ITI-67 Find Document References**.
1. Después de seleccionar un resultado, el consumidor utiliza la URL indicada en`DocumentReference.content.attachment.url`para recuperar el documento mediante**ITI-68 Retrieve Document**.

En términos generales, el proceso puede resumirse de la siguiente manera:

> El recurso `List` agrupa los elementos correspondientes a un envío documental; `DocumentReference` describe e identifica el IPS; y el recurso `Bundle` o `Binary` contiene el documento clínico completo que podrá ser recuperado por el consumidor.

## Actores de la arquitectura

### Document Source

El **Document Source** es el sistema que produce y publica el documento clínico. Puede corresponder, por ejemplo, a una ficha clínica electrónica, una plataforma hospitalaria o cualquier aplicación capaz de generar un IPS conforme a FHIR.

Sus principales responsabilidades son:

* Generar el documento IPS.
* Construir sus metadatos documentales.
* Asignar los identificadores necesarios para mantener la trazabilidad.
* Crear el `DocumentReference` que describe el documento.
* Crear el `List` que representa el conjunto de envío o `SubmissionSet`.
* Enviar estos recursos al MHD Responder mediante ITI-65.

### MHD Responder

El **MHD Responder** recibe la publicación documental y proporciona los servicios de búsqueda y recuperación. Conceptualmente, está formado por dos componentes:

* Un **índice o registro documental**, que almacena metadatos FHIR y permite realizar búsquedas.
* Un **repositorio de documentos**, que conserva el contenido completo del IPS.

Esta separación es lógica. Una implementación puede mantener ambos componentes en una misma plataforma o distribuirlos en servicios diferentes.

### Document Consumer

El **Document Consumer** es el sistema que necesita consultar documentos clínicos previamente publicados. Puede ser una ficha clínica electrónica, una aplicación clínica, un portal profesional u otro sistema autorizado.

Sus responsabilidades son:

* Buscar recursos `DocumentReference` mediante ITI-67.
* Evaluar los metadatos obtenidos.
* Seleccionar el documento requerido.
* Obtener su dirección de recuperación.
* Recuperar el IPS completo mediante ITI-68.
* Procesar el IPS y presentar su información clínica al usuario correspondiente.

## Componentes del MHD Responder

### Índice o registro documental

El índice almacena la información necesaria para organizar y localizar los documentos. En la arquitectura se representa mediante los recursos `List` y `DocumentReference`.

El índice no necesita contener toda la información clínica del IPS. Su propósito es conservar metadatos tales como:

* Paciente al que pertenece el documento.
* Tipo y categoría documental.
* Estado del documento.
* Fecha de creación o publicación.
* Autor y organización responsable.
* Identificadores documentales.
* Relación con el conjunto de envío.
* Dirección desde la que se puede recuperar el contenido completo.

### Repositorio de documentos

El repositorio conserva el contenido completo del IPS. La arquitectura muestra dos alternativas:

* **Opción A:** almacenar el IPS como un `Bundle` FHIR de tipo `document`.
* **Opción B:** almacenar el IPS serializado dentro de un recurso `Binary`.

En ambos casos, `DocumentReference.content.attachment.url` debe conducir al recurso que contiene el documento recuperable.

## Recursos FHIR involucrados

### List como SubmissionSet

El recurso `List` representa el **conjunto de envío documental** o `SubmissionSet`. No contiene directamente el documento clínico; su función es agrupar las referencias documentales publicadas como parte de una misma operación.

Entre sus principales elementos se encuentran:

* `List.identifier`: identificador del conjunto de envío.
* `List.source`: sistema, profesional u organización responsable del envío.
* `List.subject`: paciente relacionado con los documentos.
* `List.entry.item`: referencias a uno o más recursos `DocumentReference` incluidos en el envío.

Por lo tanto, un `List` puede agrupar uno o varios documentos relacionados y mantener la trazabilidad de la publicación como una unidad lógica.

La relación principal se expresa de la siguiente manera:

```
List.entry.item.reference -> DocumentReference/{id}

```

### DocumentReference como metadato del IPS

El recurso `DocumentReference` representa la descripción documental del IPS. Contiene los datos utilizados por los consumidores para buscarlo, reconocerlo y determinar cómo recuperarlo.

Entre los metadatos relevantes se encuentran:

* Tipo y categoría del documento.
* Estado documental.
* Paciente relacionado.
* Autor o autores.
* Organización custodio.
* Fecha del documento.
* Identificador maestro.
* Otros identificadores locales o de repositorio.
* Formato y tipo de contenido.
* URL de recuperación.

Los elementos fundamentales para vincular los metadatos con el contenido son:

```
DocumentReference.content.attachment.contentType
DocumentReference.content.attachment.url

```

El elemento `contentType` informa el formato del contenido, mientras que `url` indica dónde se puede recuperar.

Ejemplos conceptuales:

```
DocumentReference.content.attachment.url -> Bundle/ips-001

```

o bien:

```
DocumentReference.content.attachment.url -> Binary/ips-bin-001

```

### Bundle IPS

Cuando se utiliza la opción FHIR nativa, el IPS se conserva como un recurso `Bundle` cuyo tipo es `document`:

```
Bundle.type = document

```

Este `Bundle` constituye el documento clínico completo. Debe contener una `Composition` como primera entrada y todos los recursos clínicos referenciados por ella.

La estructura general es:

```
Bundle IPS
  ├── Composition IPS
  ├── Patient
  ├── Condition
  ├── AllergyIntolerance
  ├── MedicationStatement
  ├── Observation
  ├── Procedure
  ├── Organization
  └── Otros recursos clínicos requeridos

```

El perfil IPS aplicable debe declararse en `Bundle.meta.profile`. Además, el `Bundle.identifier` permite identificar de manera persistente el documento. Para facilitar la trazabilidad, dicho identificador debe ser coherente con el identificador maestro declarado en el `DocumentReference`.

### Composition IPS

La `Composition` es la raíz clínica y narrativa del documento. Define su organización interna y establece el contexto clínico del IPS.

Entre sus elementos se encuentran:

* `Composition.subject`: referencia al paciente.
* `Composition.author`: autor o autores del documento.
* `Composition.custodian`: organización responsable de su custodia.
* `Composition.status`: estado de la composición.
* `Composition.section`: secciones clínicas que estructuran el resumen.

Las secciones pueden incluir, entre otros antecedentes:

* Alergias e intolerancias.
* Problemas o condiciones de salud.
* Medicamentos.
* Procedimientos.
* Resultados y observaciones.
* Antecedentes clínicos relevantes.

Cada sección referencia los recursos clínicos incorporados en el mismo `Bundle` documental.

### Binary como documento serializado

En la segunda alternativa, el IPS completo se serializa en JSON o XML y se almacena en un recurso `Binary`.

Sus elementos principales son:

* `Binary.contentType`: formato del documento serializado.
* `Binary.data`: contenido del IPS codificado en Base64.

Ejemplos de tipos de contenido:

```
application/fhir+json
application/fhir+xml

```

En esta alternativa, `DocumentReference.content.attachment.url` apunta al recurso `Binary`:

```
DocumentReference.content.attachment.url -> Binary/{id}

```

Al recuperar el `Binary`, el consumidor debe decodificar `Binary.data` y procesar el `Bundle` IPS contenido en él.

## Relación entre los recursos

La arquitectura establece la siguiente cadena de relaciones:

1. `List`representa el conjunto de envío.
1. `List.entry.item`referencia uno o más`DocumentReference`.
1. Cada`DocumentReference`describe un documento IPS.
1. `DocumentReference.content.attachment.url`apunta al contenido recuperable.
1. El contenido puede estar representado directamente por un`Bundle`documental o almacenado dentro de un`Binary`.
1. El`Bundle`IPS contiene una`Composition`como primera entrada.
1. La`Composition`referencia los recursos clínicos contenidos en el documento.

La cadena conceptual puede expresarse como:

```
List
  -> DocumentReference
     -> Bundle IPS o Binary
        -> Composition IPS
           -> recursos clínicos del paciente

```

## Publicación mediante ITI-65 Provide Document Bundle

La transacción **ITI-65 Provide Document Bundle** permite que el Document Source publique el conjunto documental en el MHD Responder.

La solicitud se realiza mediante un `Bundle` FHIR de tipo `transaction`. Este paquete de publicación puede incorporar:

* Un `List` que representa el `SubmissionSet`.
* Uno o más recursos `DocumentReference`.
* El contenido de cada documento, representado mediante un `Bundle` IPS o un `Binary`, según la alternativa adoptada.

El proceso de publicación es el siguiente:

1. El Document Source genera el IPS.
1. Crea el`DocumentReference`con los metadatos del documento.
1. Define en`content.attachment.url`la referencia al contenido recuperable.
1. Crea el`List`y agrega la referencia al`DocumentReference`en`entry.item`.
1. Incorpora los recursos en un`Bundle`de tipo`transaction`.
1. Envía el paquete al MHD Responder mediante ITI-65.
1. El MHD Responder registra los metadatos y conserva el documento.

El propósito de esta transacción es que el envío se procese como una unidad coherente, manteniendo las relaciones entre el conjunto de envío, los metadatos y el contenido documental.

## Búsqueda mediante ITI-67 Find Document References

La transacción **ITI-67 Find Document References** permite buscar documentos utilizando los metadatos almacenados en el índice.

El consumidor realiza una búsqueda sobre el recurso `DocumentReference`, aplicando criterios tales como:

* Paciente.
* Tipo documental.
* Categoría.
* Estado.
* Fecha.
* Autor.
* Organización custodio.
* Identificadores.

Ejemplo conceptual de búsqueda por paciente y estado:

```
GET [base]/DocumentReference?subject=Patient/123&status=current

```

La respuesta corresponde a un `Bundle` FHIR de tipo `searchset` que contiene los `DocumentReference` coincidentes:

```
Bundle (type = searchset)
  ├── DocumentReference 1
  ├── DocumentReference 2
  └── DocumentReference N

```

Cada resultado entrega los metadatos necesarios para que el consumidor evalúe el documento y obtenga su URL de recuperación.

La búsqueda no devuelve necesariamente el IPS completo. Devuelve principalmente los recursos `DocumentReference` que permiten identificarlo y localizarlo.

## Búsqueda opcional del SubmissionSet mediante ITI-66

La transacción **ITI-66 Find Document Lists** permite buscar los recursos `List` utilizados como conjuntos de envío. Esta búsqueda es útil cuando se requiere conocer qué documentos fueron publicados conjuntamente o recuperar información sobre el contexto del envío.

ITI-66 complementa la búsqueda documental, pero no reemplaza la búsqueda de `DocumentReference` mediante ITI-67.

## Recuperación mediante ITI-68 Retrieve Document

Después de seleccionar un `DocumentReference`, el consumidor obtiene la dirección indicada en:

```
DocumentReference.content.attachment.url

```

Luego ejecuta la transacción **ITI-68 Retrieve Document** para recuperar el documento completo.

Dependiendo de la alternativa de almacenamiento, la operación puede recuperar directamente un `Bundle` IPS:

```
GET [base]/Bundle/ips-001

```

o un recurso `Binary`:

```
GET [base]/Binary/ips-bin-001

```

Si se recupera un `Bundle`, el consumidor puede procesar directamente el documento FHIR. Si se recupera un `Binary`, debe decodificar su contenido y reconstruir el IPS serializado.

## Alternativas de almacenamiento del IPS

| | | |
| :--- | :--- | :--- |
| Representación | Recurso`Bundle`de tipo`document` | Documento IPS serializado dentro de`Binary.data` |
| URL de recuperación | `Bundle/{id}` | `Binary/{id}` |
| Tipo de contenido | `application/fhir+json`o`application/fhir+xml` | `application/fhir+json`o`application/fhir+xml` |
| Procesamiento | El servidor y el consumidor manejan el IPS como recurso FHIR | El consumidor recupera y decodifica el contenido serializado |
| Ventaja principal | Representación FHIR nativa y directamente procesable | Conservación del documento como una unidad serializada |

La alternativa seleccionada debe aplicarse de manera coherente en el `DocumentReference`, el repositorio y las capacidades declaradas por el servidor.

## Identificadores y trazabilidad

Los identificadores permiten correlacionar el envío, los metadatos y el documento clínico.

### Identificador del SubmissionSet

`List.identifier` identifica el conjunto de envío. Su alcance corresponde a la publicación que agrupa uno o más documentos.

### Identificador maestro del documento

`DocumentReference.masterIdentifier` identifica de manera persistente el documento IPS descrito. No corresponde necesariamente al identificador técnico del recurso FHIR.

### Identificador del Bundle documental

`Bundle.identifier` identifica el documento FHIR completo. Debe mantenerse una correspondencia clara entre este valor y el identificador maestro del `DocumentReference`.

### Identificadores adicionales

`DocumentReference.identifier` puede utilizarse para registrar identificadores locales, institucionales o asignados por el repositorio.

Es importante distinguir entre:

* El identificador lógico del recurso, como `DocumentReference.id` o `Bundle.id`.
* El identificador de negocio o documental, como `masterIdentifier` o `Bundle.identifier`.
* La URL utilizada para recuperar una instancia concreta del documento.

## Flujo completo de extremo a extremo

### Etapa 1: producción y publicación

1. El sistema productor reúne la información clínica del paciente.
1. Genera una`Composition`IPS.
1. Construye el`Bundle`documental con la`Composition`y los recursos clínicos referenciados.
1. Crea el`DocumentReference`que describe el IPS.
1. Configura`content.attachment.url`para apuntar al`Bundle`o`Binary`recuperable.
1. Crea el`List`que representa el conjunto de envío.
1. Publica los recursos mediante ITI-65.

### Etapa 2: registro y almacenamiento

1. El MHD Responder recibe el paquete de publicación.
1. Registra el`List`y los`DocumentReference`en el índice documental.
1. Almacena el contenido IPS en el repositorio.
1. Mantiene las referencias necesarias entre los recursos.

### Etapa 3: búsqueda

1. El consumidor consulta`DocumentReference`mediante ITI-67.
1. El MHD Responder devuelve un`Bundle`de tipo`searchset`.
1. El consumidor examina los metadatos y selecciona el documento apropiado.
1. Obtiene la URL desde`content.attachment.url`.

### Etapa 4: recuperación y uso

1. El consumidor invoca la URL de recuperación mediante ITI-68.
1. El repositorio devuelve el`Bundle`IPS o el`Binary`correspondiente.
1. El consumidor procesa el documento.
1. La información del IPS queda disponible para su uso clínico.

## Resumen de transacciones

| | | |
| :--- | :--- | :--- |
| ITI-65 | Provide Document Bundle | Publicar el conjunto de envío, sus metadatos y los documentos asociados. |
| ITI-66 | Find Document Lists | Buscar los`List`que representan conjuntos de envío. |
| ITI-67 | Find Document References | Buscar los metadatos de documentos registrados. |
| ITI-68 | Retrieve Document | Recuperar el contenido completo de un documento seleccionado. |

## Consideraciones de implementación

Para mantener la coherencia de la arquitectura, una implementación debe asegurar que:

* Cada `List.entry.item` resuelva al `DocumentReference` correspondiente.
* Cada `DocumentReference.content.attachment.url` permita recuperar el documento correcto.
* El `contentType` declarado coincida con el formato efectivamente recuperado.
* El `Bundle` IPS sea de tipo `document`.
* La primera entrada del `Bundle` documental corresponda a la `Composition`.
* Los recursos referenciados por la `Composition` estén incluidos y sean resolubles dentro del documento.
* Los identificadores documentales se mantengan estables y coherentes.
* Las búsquedas se realicen sobre los metadatos y no sobre el contenido completo del IPS.
* La recuperación entregue el documento asociado al `DocumentReference` seleccionado.
* Los servicios apliquen los controles de autenticación, autorización, auditoría y protección de datos requeridos por el contexto de uso.

## Conclusión

La arquitectura MHD permite administrar documentos IPS separando claramente la función de **registro y búsqueda de metadatos** de la función de **almacenamiento y recuperación del contenido clínico completo**.

El `List` representa el conjunto de envío, el `DocumentReference` describe el documento y proporciona su dirección de recuperación, y el `Bundle` o `Binary` contiene el IPS. Mediante ITI-65 el documento se publica, mediante ITI-67 se localiza y mediante ITI-68 se recupera para su utilización clínica. ITI-66 puede utilizarse adicionalmente cuando se requiere buscar los conjuntos de envío representados por recursos `List`.

# DocumentReference e IPS en una arquitectura MHD

## Introducción

La arquitectura presentada explica la relación entre un recurso `DocumentReference` y un documento **International Patient Summary (IPS)** dentro del perfil **Mobile access to Health Documents (MHD)** de IHE.

El concepto central es que `DocumentReference` **no es el documento clínico IPS**. Su función es registrar e indexar sus metadatos para permitir que otros sistemas puedan buscarlo, identificarlo y recuperar su contenido completo.

El IPS propiamente tal se conserva como un documento FHIR compuesto por:

* Un `Bundle` de tipo `document`.
* Una `Composition` como primera entrada.
* Los recursos clínicos referenciados por esa `Composition`.

Como alternativa, el `Bundle` IPS completo puede almacenarse serializado dentro de un recurso `Binary`.

## Principio fundamental

La arquitectura separa claramente dos elementos:

| | |
| :--- | :--- |
| `DocumentReference` | Describe, identifica e indexa el documento IPS. |
| `Bundle`IPS o`Binary` | Contiene el documento clínico completo que será recuperado. |

Por lo tanto:

> `DocumentReference` permite encontrar el IPS, pero no sustituye al IPS.

La relación entre ambos se establece principalmente mediante:

```
DocumentReference.content.attachment.url

```

Este elemento debe apuntar al documento completo recuperable y no solamente a la `Composition`.

## Participantes de la arquitectura

La arquitectura considera tres participantes principales:

1. **Sistema fuente o Document Source**.
1. **Servidor MHD o Document Recipient**.
1. **Consumidor o Document Consumer**.

### Sistema fuente o Document Source

El **Document Source** es el sistema que crea y publica el IPS. Puede corresponder a una ficha clínica electrónica, un sistema hospitalario o cualquier plataforma capaz de construir un documento IPS válido.

Sus principales responsabilidades son:

* Reunir la información clínica del paciente.
* Generar la `Composition` IPS.
* Construir el `Bundle` documental completo.
* Crear el `DocumentReference` con los metadatos del IPS.
* Mantener la concordancia entre los identificadores del documento.
* Publicar los recursos mediante la transacción ITI-65.

El producto clínico generado por este actor es un `Bundle` FHIR cuyo tipo debe ser:

```
Bundle.type = document

```

### Servidor MHD o Document Recipient

El **Document Recipient** recibe la publicación y proporciona los servicios necesarios para registrar, buscar y recuperar documentos.

En la arquitectura se distinguen dos funciones internas:

* **Índice documental:** registra los recursos `DocumentReference` y sus metadatos.
* **Almacenamiento documental:** conserva el contenido IPS como `Bundle` o `Binary`.

Ambas funciones pueden implementarse en un mismo servidor o distribuirse en componentes diferentes. Lo relevante es que las referencias entre los metadatos y el contenido sean válidas y resolubles.

### Consumidor o Document Consumer

El **Document Consumer** corresponde al sistema que necesita localizar y utilizar el IPS. Puede ser un HIS, un portal clínico, una ficha clínica electrónica, una aplicación móvil u otro sistema autorizado.

Sus responsabilidades son:

* Buscar `DocumentReference` mediante ITI-67.
* Examinar los metadatos encontrados.
* Seleccionar el IPS apropiado.
* Obtener la URL del documento.
* Recuperar el IPS completo mediante ITI-68.
* Procesar y presentar la información clínica.

## El índice documental

El índice documental almacena los recursos `DocumentReference`. Estos recursos contienen información que permite clasificar y localizar los documentos disponibles sin tener que recuperar todo su contenido clínico.

En la arquitectura, el `DocumentReference` del IPS incluye al menos los siguientes conceptos:

* Estado del documento.
* Tipo documental.
* Paciente al que pertenece.
* Identificador maestro.
* Dirección del contenido recuperable.
* Autor.
* Organización custodio.

También puede incorporar categorías, fechas, formatos, contexto clínico y otros identificadores necesarios para la búsqueda y trazabilidad.

## Elementos principales de DocumentReference

### Estado documental

El estado del documento se registra en:

```
DocumentReference.status

```

En el ejemplo se utiliza:

```
DocumentReference.status = current

```

Esto indica que el documento corresponde a la versión vigente dentro del ciclo documental definido por el sistema.

### Tipo documental

El tipo permite reconocer que el documento corresponde a un resumen clínico del paciente o IPS:

```
DocumentReference.type

```

La imagen utiliza como ejemplo el código LOINC:

```
60591-5 | Patient summary Document

```

Este código permite expresar semánticamente que el contenido corresponde a un documento de resumen del paciente.

### Paciente

La relación con el paciente se expresa mediante:

```
DocumentReference.subject -> Patient/{id}

```

Este elemento es fundamental para buscar todos los documentos asociados a una persona determinada.

### Autor y custodio

El `DocumentReference` puede identificar quién creó el documento y qué organización es responsable de su custodia.

Los elementos involucrados son:

```
DocumentReference.author
DocumentReference.custodian

```

Dependiendo del elemento y del perfil aplicable, estas referencias pueden relacionarse con recursos como `PractitionerRole` y `Organization`.

Conceptualmente:

* El **autor** representa a quien participa en la creación del documento.
* El **custodio** representa a la organización responsable de mantenerlo y ponerlo a disposición.

### Identificador maestro

El identificador maestro del documento se registra en:

```
DocumentReference.masterIdentifier

```

Este identificador debe corresponder al identificador documental declarado en:

```
Bundle.identifier

```

La igualdad corresponde al par formado por `system` y `value`, no a una referencia FHIR entre recursos.

Ejemplo conceptual:

```
DocumentReference.masterIdentifier.system = http://hospital.example.org/identifiers/ips
DocumentReference.masterIdentifier.value  = IPS-2026-0001

Bundle.identifier.system = http://hospital.example.org/identifiers/ips
Bundle.identifier.value  = IPS-2026-0001

```

Esta concordancia permite demostrar que el `DocumentReference` describe precisamente el `Bundle` documental recuperado.

### Dirección del documento completo

La dirección de recuperación se declara en:

```
DocumentReference.content.attachment.url

```

Esta URL puede apuntar a una de las dos representaciones válidas mostradas en la arquitectura:

```
Bundle/ips-001

```

o:

```
Binary/ips-bin-001

```

El destino debe contener el IPS completo.

## Representación del IPS mediante Bundle

La primera alternativa consiste en almacenar el IPS como un recurso `Bundle` FHIR nativo.

Sus características esenciales son:

```
Bundle.type = document
Bundle.meta.profile = perfil IPS aplicable
Bundle.entry[0].resource = Composition IPS

```

El `Bundle` representa la unidad documental completa. Debe contener tanto la estructura narrativa definida por la `Composition` como los recursos clínicos referenciados por ella.

Ejemplo de organización interna:

```
Bundle/ips-001
  ├── entry[0]: Composition IPS
  ├── Patient
  ├── Condition
  ├── AllergyIntolerance
  ├── MedicationStatement
  ├── Observation
  ├── Organization
  └── Otros recursos clínicos requeridos

```

El perfil IPS aplicable debe declararse mediante su URL canónica en `Bundle.meta.profile`.

## La Composition dentro del IPS

La `Composition` es la cabecera clínica y organizativa del documento. Define el paciente, los autores, el custodio, el estado y las secciones clínicas que conforman el resumen.

Entre sus elementos relevantes se encuentran:

* `Composition.subject`: referencia al paciente.
* `Composition.author`: autor o autores del IPS.
* `Composition.custodian`: organización custodio.
* `Composition.status`: estado de la composición.
* `Composition.section`: secciones del resumen clínico.

Las secciones de la `Composition` pueden referenciar recursos como:

* `Condition` para problemas o diagnósticos.
* `AllergyIntolerance` para alergias e intolerancias.
* `MedicationStatement` para antecedentes de medicamentos.
* `Observation` para resultados y observaciones clínicas.
* `Organization` para organizaciones participantes.
* Otros recursos exigidos o permitidos por el perfil IPS.

### Por qué no se debe apuntar solamente a Composition

La `Composition` no constituye por sí sola el documento IPS completo. Es solamente la estructura clínica que encabeza y organiza el documento.

El IPS completo corresponde al `Bundle` documental que contiene:

1. La`Composition`.
1. El`Patient`.
1. Los recursos clínicos referenciados.
1. Las organizaciones, autores y demás participantes necesarios.

Por esta razón, lo siguiente es incorrecto para representar el contenido completo:

```
DocumentReference.content.attachment.url -> Composition/{id}

```

La referencia debe conducir al documento completo:

```
DocumentReference.content.attachment.url -> Bundle/ips-001

```

La regla se puede resumir así:

> `Composition` encabeza el IPS, pero el IPS clínico completo vive en el `Bundle` de tipo `document`.

## Representación del IPS mediante Binary

La segunda alternativa consiste en serializar el `Bundle` IPS completo en JSON o XML y almacenarlo dentro de un recurso `Binary`.

En ese caso:

```
DocumentReference.content.attachment.url -> Binary/ips-bin-001

```

El recurso `Binary` contiene:

* `Binary.contentType`: formato de serialización del IPS.
* `Binary.data`: documento codificado en Base64.

Ejemplos de tipos de contenido:

```
application/fhir+json
application/fhir+xml

```

Después de recuperar el `Binary`, el consumidor debe:

1. Decodificar el contenido Base64.
1. Interpretar el JSON o XML resultante.
1. Procesar el`Bundle`IPS completo.

Aunque se utilice `Binary`, el contenido clínico sigue siendo un `Bundle` IPS de tipo `document`; solamente cambia la manera en que se almacena y entrega.

## Comparación de las dos opciones

| | | |
| :--- | :--- | :--- |
| Recurso recuperado | `Bundle` | `Binary` |
| Contenido | Documento FHIR directamente representado como recurso | `Bundle`IPS serializado y codificado en Base64 |
| URL de ejemplo | `Bundle/ips-001` | `Binary/ips-bin-001` |
| Procesamiento del consumidor | Procesa directamente el`Bundle` | Decodifica el`Binary`y luego procesa el`Bundle` |
| Unidad clínica | `Bundle`de tipo`document` | El mismo`Bundle`documental contenido en`Binary.data` |

La alternativa seleccionada debe declararse de forma coherente en `DocumentReference.content.attachment.contentType` y `DocumentReference.content.attachment.url`.

## Publicación mediante ITI-65

El sistema fuente publica el IPS en el servidor MHD mediante la transacción:

```
ITI-65 Provide Document Bundle

```

El proceso conceptual es el siguiente:

1. El Document Source genera el`Bundle`IPS.
1. Crea el`DocumentReference`que indexará el documento.
1. Iguala`DocumentReference.masterIdentifier`con`Bundle.identifier`.
1. Configura`content.attachment.url`para apuntar al`Bundle`o al`Binary`.
1. Incorpora los recursos requeridos en el paquete de publicación.
1. Envía la transacción al Document Recipient.
1. El servidor registra los metadatos y almacena el contenido recuperable.

El resultado esperado es que el IPS quede disponible tanto para búsquedas documentales como para recuperación posterior.

## Búsqueda mediante ITI-67

El consumidor localiza los documentos mediante:

```
ITI-67 Find Document References

```

Esta transacción consulta los recursos `DocumentReference` del índice documental.

Los criterios de búsqueda pueden incluir:

* Paciente.
* Estado documental.
* Tipo.
* Categoría.
* Fecha.
* Autor.
* Custodio.
* Identificadores.

Ejemplo conceptual de búsqueda:

```
GET [base]/DocumentReference?subject=Patient/123&status=current&type=http://loinc.org|60591-5

```

La respuesta corresponde a un `Bundle` FHIR de tipo `searchset`:

```
Bundle (type = searchset)
  ├── DocumentReference 1
  ├── DocumentReference 2
  └── DocumentReference N

```

El consumidor recibe metadatos, no necesariamente el documento IPS completo. Luego debe examinar los resultados, seleccionar el documento adecuado y utilizar su URL de recuperación.

## Recuperación mediante ITI-68

Una vez seleccionado el `DocumentReference`, el consumidor utiliza:

```
DocumentReference.content.attachment.url

```

para ejecutar:

```
ITI-68 Retrieve Document

```

Si la URL apunta a un `Bundle`, la recuperación puede representarse conceptualmente como:

```
GET [base]/Bundle/ips-001

```

Si apunta a un `Binary`:

```
GET [base]/Binary/ips-bin-001

```

El resultado final debe permitir al consumidor obtener el documento IPS FHIR completo.

## Flujo completo de extremo a extremo

### 1. Generación

1. El sistema fuente reúne la información clínica.
1. Genera la`Composition`IPS.
1. Construye el`Bundle`de tipo`document`.
1. Incluye la`Composition`como primera entrada.
1. Incorpora los recursos clínicos referenciados.

### 2. Indexación

1. El sistema fuente crea el`DocumentReference`.
1. Declara el paciente en`subject`.
1. Declara el tipo documental, por ejemplo LOINC`60591-5`.
1. Declara el autor y el custodio.
1. Asigna el identificador maestro.
1. Configura la URL hacia el IPS completo.

### 3. Publicación

1. El Document Source envía los recursos mediante ITI-65.
1. El MHD Recipient registra el`DocumentReference`.
1. El contenido IPS queda almacenado como`Bundle`o`Binary`.

### 4. Búsqueda

1. El consumidor ejecuta ITI-67.
1. El servidor devuelve un`Bundle`de tipo`searchset`.
1. El consumidor revisa los`DocumentReference`encontrados.
1. Selecciona el documento correspondiente.

### 5. Recuperación

1. El consumidor obtiene`content.attachment.url`.
1. Ejecuta ITI-68 sobre esa dirección.
1. Recupera el`Bundle`IPS o el`Binary`.
1. Procesa el documento para su uso clínico.

## Reglas clave

### Regla 1: DocumentReference indexa el IPS

`DocumentReference` contiene metadatos y facilita la búsqueda, pero no reemplaza al documento clínico.

### Regla 2: attachment.url apunta al documento completo

`DocumentReference.content.attachment.url` debe apuntar al `Bundle` IPS completo o al `Binary` que lo contiene.

### Regla 3: los identificadores deben concordar

El par `system` y `value` de `DocumentReference.masterIdentifier` debe concordar con el identificador documental expresado en `Bundle.identifier`.

### Regla 4: el IPS vive en el Bundle

La `Composition` encabeza y estructura el documento, pero el IPS clínico completo corresponde al `Bundle` de tipo `document`.

## Lista de verificación para la implementación

Antes de publicar un IPS, se debe comprobar que:

* `DocumentReference.status` tenga un valor válido.
* `DocumentReference.type` identifique correctamente el resumen clínico.
* `DocumentReference.subject` referencie al paciente correcto.
* `DocumentReference.masterIdentifier` esté informado.
* `Bundle.identifier` sea coherente con el identificador maestro.
* `DocumentReference.content.attachment.url` sea resoluble.
* La URL apunte al documento completo y no solamente a `Composition`.
* `DocumentReference.content.attachment.contentType` coincida con el formato recuperado.
* El IPS sea un `Bundle` de tipo `document`.
* `Bundle.meta.profile` declare el perfil IPS aplicable.
* La primera entrada del `Bundle` contenga la `Composition`.
* La `Composition` referencie al paciente correcto.
* Los recursos clínicos referenciados estén incluidos en el documento.
* El autor y el custodio estén representados de acuerdo con el perfil aplicable.
* El documento pueda encontrarse mediante ITI-67.
* El documento pueda recuperarse mediante ITI-68.

## Conclusión

En una arquitectura MHD, el `DocumentReference` actúa como el registro documental del IPS. Permite describirlo, identificarlo, asociarlo con un paciente y proporcionar la URL desde la que puede recuperarse.

El contenido clínico completo no reside en el `DocumentReference` ni únicamente en la `Composition`. Reside en un `Bundle` FHIR de tipo `document`, encabezado por la `Composition` y acompañado por todos los recursos clínicos referenciados. Como alternativa técnica, ese `Bundle` puede almacenarse serializado dentro de un `Binary`.

El sistema fuente publica el documento mediante ITI-65, el consumidor localiza su `DocumentReference` mediante ITI-67 y finalmente recupera el IPS completo mediante ITI-68.

