### Aspectos de seguridad

#### Introducción

El intercambio de documentos clínicos mediante **IHE Mobile access to Health Documents (MHD)** involucra información personal y sanitaria sensible. Por esta razón, la implementación debe aplicar controles de seguridad en todas las capas: aplicación, API FHIR, transporte, infraestructura de intercambio, repositorios y auditoría.

Esta guía contempla dos formas de acceso al servicio MHD:

1. acceso directo mediante una API FHIR protegida; y
2. acceso a través de un bus de interoperabilidad **X-Road**.

X-Road agrega identidad organizacional, control de acceso entre subsistemas, protección del transporte, firma de mensajes, sellado de tiempo y evidencia del intercambio. Sin embargo, **X-Road no reemplaza la autenticación del usuario ni la autorización clínica aplicada por el servicio MHD**.

#### Principios generales

La arquitectura debe aplicar los siguientes principios:

- **defensa en profundidad:** ningún control debe constituir por sí solo toda la seguridad del sistema;
- **mínimo privilegio:** cada sistema y usuario recibe solamente los permisos necesarios;
- **necesidad de conocer:** el acceso se restringe al paciente, documento y propósito autorizado;
- **confianza explícita:** toda solicitud debe ser autenticada y autorizada;
- **trazabilidad:** las operaciones relevantes deben quedar registradas y correlacionadas;
- **protección durante todo el ciclo de vida:** los datos deben protegerse durante su transmisión, procesamiento, almacenamiento, respaldo y eliminación;
- **minimización de datos:** las respuestas y registros deben contener únicamente la información necesaria;
- **seguridad desde el diseño:** los controles deben formar parte de la arquitectura y no incorporarse solamente al final del desarrollo.

#### Modelo de seguridad por capas

| Capa | Controles principales | Responsabilidad |
|---|---|---|
| Identidad organizacional | Certificados, identificación de miembros y subsistemas, configuración de confianza | X-Road |
| Transporte entre organizaciones | TLS mutuo, cifrado del canal y validación de certificados | X-Road |
| Evidencia del intercambio | Firma de mensajes, registro y sellado de tiempo | X-Road |
| Autenticación de aplicación o usuario | OAuth, IUA, OpenID Connect o mecanismo institucional equivalente | Plataforma de identidad y aplicación |
| Autorización clínica | Rol, organización, paciente, propósito de uso, consentimiento y tipo de documento | Servicio MHD |
| Validación de contenido | Validación FHIR, perfiles MHD, perfiles Core AR y reglas de negocio | Servidor FHIR/MHD |
| Protección del repositorio | Cifrado, control de acceso, respaldo y gestión de claves | Repositorio FHIR y documental |
| Auditoría clínica y de seguridad | `AuditEvent`, registros ATNA/BALP, SIEM y correlación con X-Road | Aplicaciones e infraestructura |

#### Arquitectura de seguridad propuesta

El siguiente esquema muestra la separación entre la seguridad provista por X-Road y los controles propios del servicio MHD.

<figure>
  <img
    src="seguridad-mhd-xroad.svg"
    alt="Seguridad para el intercambio MHD mediante X-Road"
    style="width:100%; height:auto;"
  />
  <figcaption>
    Seguridad de infraestructura X-Road y seguridad clínica MHD.
  </figcaption>
</figure>



#### Autenticación

##### Identificación proporcionada por X-Road

X-Road identifica a las organizaciones participantes, sus servidores de seguridad y los subsistemas que consumen o proporcionan servicios. Esta identidad se sustenta en certificados emitidos por autoridades de certificación reconocidas por la instancia X-Road.

El servidor de seguridad del proveedor debe permitir el acceso únicamente a los miembros, subsistemas o grupos autorizados para utilizar el servicio MHD publicado.

Esta autenticación permite responder preguntas como:

- ¿qué organización envió la solicitud?;
- ¿qué subsistema consumió el servicio?;
- ¿a qué servicio X-Road fue dirigida la operación?; y
- ¿por qué servidores de seguridad circuló el mensaje?

No permite determinar por sí sola qué persona utilizó el sistema ni si esa persona puede acceder a los documentos clínicos del paciente.

##### Autenticación de usuarios y aplicaciones

Las solicitudes MHD deben incorporar una identidad de aplicación y, cuando corresponda, la identidad del usuario que originó la operación.

Puede utilizarse **IHE Internet User Authorization (IUA)**, OAuth u otro mecanismo institucional equivalente. Cuando se empleen tokens de acceso, el servicio debe validar como mínimo:

- firma del token;
- emisor (`iss`);
- audiencia (`aud`);
- vigencia (`exp` y, cuando corresponda, `nbf`);
- identificador del cliente;
- identidad del usuario, si existe;
- ámbitos o permisos (`scope`);
- identificador único del token (`jti`), cuando corresponda; y
- contexto organizacional declarado.

Los tokens deben ser de corta duración y no deben almacenarse en registros, URLs, mensajes de error ni trazas técnicas.

X-Road permite transportar encabezados HTTP hacia el servicio proveedor. Por lo tanto, un token puede acompañar la solicitud a través del bus, pero debe ser validado por el componente de autorización o por el servicio MHD receptor.

#### Autorización

La autorización debe evaluarse nuevamente en el punto de acceso al servicio MHD. No es suficiente que el subsistema consumidor esté autorizado en X-Road.

La decisión de acceso debería considerar:

- organización y subsistema de origen;
- identidad de la aplicación;
- identidad y rol del usuario;
- relación del usuario con la organización;
- paciente involucrado;
- propósito de uso;
- tipo y categoría del documento;
- nivel de confidencialidad;
- custodio del documento;
- consentimiento y restricciones aplicables; y
- operación solicitada.

Cuando se utilice IUA, pueden definirse ámbitos asociados a las transacciones MHD:

| Transacción | Ámbito general | Acceso esperado |
|---|---|---|
| ITI-65 Provide Document Bundle | `ITI-65` | Registro de documentos y metadatos autorizados. |
| ITI-67 Find Document References | `ITI-67` | Búsqueda de referencias documentales autorizadas. |
| ITI-68 Retrieve Document | `ITI-68` | Recuperación del contenido documental autorizado. |

Estos ámbitos no impiden aplicar restricciones adicionales por paciente, usuario, organización, tipo documental o propósito de uso.

#### Protección del transporte

Todas las comunicaciones deben utilizar HTTPS.

En una integración mediante X-Road deben protegerse tres tramos:

1. sistema consumidor → servidor de seguridad X-Road del consumidor;
2. servidor de seguridad del consumidor → servidor de seguridad del proveedor; y
3. servidor de seguridad del proveedor → servicio MHD.

El tramo entre servidores de seguridad es protegido por X-Road mediante TLS mutuamente autenticado. Para los tramos internos entre los sistemas de información y sus servidores de seguridad también se recomienda TLS mutuo, especialmente cuando se trata de servicios clínicos privilegiados.

Los endpoints internos del servicio MHD no deberían quedar expuestos directamente a Internet cuando el acceso se haya definido exclusivamente mediante X-Road.

#### Seguridad específica de las transacciones MHD

##### ITI-65: registro de documentos

Antes de aceptar un `Bundle` de tipo `transaction`, el Document Recipient debe:

- autenticar y autorizar al sistema solicitante;
- validar el `Bundle` contra FHIR R4, IHE MHD y los perfiles nacionales aplicables;
- verificar que todas las referencias internas sean coherentes;
- validar la identidad del paciente;
- restringir tipos MIME y tamaños máximos;
- impedir la incorporación de contenido ejecutable no autorizado;
- controlar duplicados e identificadores reutilizados;
- procesar la transacción de forma atómica;
- verificar `hash` y `size` cuando sean aplicables;
- registrar el resultado completo de la operación; y
- conservar la procedencia del documento mediante `Provenance` cuando corresponda.

Si `DocumentReference.content.attachment.url` apunta a una dirección externa, el receptor debe prevenir ataques de tipo **Server-Side Request Forgery (SSRF)**. Para ello debe utilizar una lista de dominios o repositorios permitidos, bloquear redes internas no autorizadas, impedir redirecciones inseguras y aplicar límites de tiempo y tamaño.

##### ITI-67: búsqueda de documentos

La búsqueda puede revelar la existencia de pacientes o documentos incluso cuando no entrega el contenido clínico. Por lo tanto, el Document Responder debe:

- autorizar la consulta antes de ejecutar la búsqueda;
- restringir los resultados al paciente y documentos permitidos;
- limitar cantidad de resultados y paginación;
- aplicar límites de frecuencia para evitar enumeración o extracción masiva;
- evitar incluir información innecesaria en el `Bundle searchset`;
- proteger los parámetros de consulta almacenados en registros; y
- auditar búsquedas exitosas, denegadas y anómalas.

Los identificadores del paciente incluidos en una URL pueden quedar almacenados en historiales, proxies o registros. Cuando sea apropiado, puede utilizarse una búsqueda FHIR mediante `POST [base]/DocumentReference/_search`, manteniendo los parámetros fuera de la URL. Esto no reemplaza el uso de HTTPS ni la protección de los registros.

##### ITI-68: recuperación de documentos

La autorización debe comprobarse nuevamente al recuperar el documento. Haber obtenido previamente un `DocumentReference` no constituye autorización suficiente para acceder a su contenido.

El Document Responder debe:

- validar la identidad y permisos del solicitante;
- comprobar la autorización específica sobre el paciente y documento;
- validar que la URL solicitada corresponde a un repositorio autorizado;
- impedir acceso por identificadores predecibles sin control de autorización;
- validar el tipo MIME de la respuesta;
- aplicar límites de tamaño y tiempo de descarga;
- verificar la integridad mediante `hash` cuando esté disponible;
- impedir redirecciones hacia destinos no confiables; y
- auditar tanto recuperaciones exitosas como fallidas.

Cuando se utilicen URLs temporales, estas deben tener una vigencia breve, alcance restringido y no deben reutilizarse como mecanismo permanente de autorización.

#### Seguridad aportada por X-Road

Cuando las transacciones MHD circulan mediante X-Road, la infraestructura aporta:

- identificación de miembros, subsistemas y servicios;
- autenticación mediante certificados;
- TLS mutuo entre servidores de seguridad;
- cifrado de los mensajes durante el transporte entre servidores;
- firma digital de los mensajes intercambiados;
- consulta del estado de certificados mediante OCSP;
- registro local de solicitudes y respuestas;
- sellado de tiempo de los registros;
- evidencia verificable del intercambio; y
- control de acceso del subsistema consumidor al servicio publicado.

Estas capacidades permiten demostrar qué organizaciones intercambiaron información y proteger la comunicación entre ellas. No sustituyen:

- la autenticación del usuario final;
- la autorización clínica;
- la evaluación del consentimiento;
- la validación de recursos FHIR;
- la protección del repositorio; ni
- la auditoría clínica detallada.

#### Registros y auditoría

La solución debe mantener dos niveles complementarios de trazabilidad:

##### Evidencia de intercambio X-Road

Los servidores de seguridad registran las solicitudes y respuestas y pueden generar evidencia firmada y sellada en el tiempo. Estos registros permiten acreditar el intercambio entre organizaciones.

Debido a que los mensajes pueden contener información clínica, se debe revisar la configuración de los registros X-Road. Cuando el cuerpo de los mensajes sea almacenado, los registros deben cifrarse y protegerse con controles equivalentes a los aplicados al repositorio clínico. Si la política permite registrar solamente metadatos, debe conservarse suficiente información para la trazabilidad sin duplicar innecesariamente los documentos clínicos.

##### Auditoría FHIR y clínica

El servicio MHD debe registrar los eventos relevantes mediante `AuditEvent` o un mecanismo equivalente compatible con ATNA/BALP.

Cada evento debería registrar, cuando corresponda:

- fecha y hora;
- identificador de correlación;
- transacción MHD ejecutada;
- identidad del usuario;
- aplicación cliente;
- miembro y subsistema X-Road;
- organización solicitante;
- paciente afectado;
- documento o referencia documental;
- decisión de autorización;
- resultado de la operación; y
- origen de red.

Los eventos de auditoría no deben admitir modificaciones o eliminaciones ordinarias y su acceso debe limitarse a funciones autorizadas de seguridad, privacidad y control.

`AuditEvent` registra el uso o acceso a la información. `Provenance`, en cambio, documenta el origen y las transformaciones que dieron lugar al estado actual de un recurso. Ambos recursos cumplen funciones diferentes y pueden utilizarse de manera complementaria.

#### Correlación de solicitudes

Cada operación debe contar con un identificador de correlación único que acompañe la solicitud durante todo su recorrido:

```text
Aplicación → X-Road consumidor → X-Road proveedor → API MHD → repositorio
```

El identificador debe permitir relacionar:

- registro técnico de la aplicación;
- evidencia de intercambio X-Road;
- decisión de autorización;
- `AuditEvent` FHIR;
- respuesta FHIR u `OperationOutcome`; y
- evento almacenado en el SIEM.

El identificador no debe contener RUT, DNI, nombre del paciente u otra información clínica.

#### Protección de datos almacenados

Los documentos, metadatos, índices, respaldos y registros deben protegerse mediante:

- cifrado en reposo;
- gestión segura y rotación de claves;
- separación de funciones administrativas;
- control de acceso a bases de datos y almacenamiento;
- respaldos cifrados y pruebas periódicas de restauración;
- política de retención y eliminación segura;
- monitoreo de accesos privilegiados; y
- segmentación de redes.

Las claves privadas utilizadas para firma, autenticación o cifrado deberían almacenarse en dispositivos o servicios especializados de gestión de claves. El acceso a estas claves debe ser restringido y auditado.

#### Manejo de errores

Los errores deben representarse mediante códigos HTTP apropiados y, cuando corresponda, mediante un recurso FHIR `OperationOutcome`.

Los mensajes no deben revelar:

- existencia de documentos no autorizados;
- datos personales del paciente;
- rutas internas;
- consultas de base de datos;
- tokens o credenciales;
- detalles de configuración; ni
- trazas completas de excepciones.

La respuesta frente a una denegación debe definirse mediante una política consistente:

| Respuesta | Uso recomendado |
|---|---|
| `401 Unauthorized` | No existe una autenticación válida. |
| `403 Forbidden` | El solicitante está autenticado, pero no está autorizado y puede conocer esa condición. |
| `404 Not Found` | Se desea evitar revelar la existencia del recurso. |
| `200 OK` con resultados filtrados o vacíos | Búsquedas donde revelar la existencia de registros no autorizados produciría una fuga de información. |

#### Amenazas y controles

| Amenaza | Controles principales |
|---|---|
| Suplantación de una organización | PKI X-Road, certificados, TLS mutuo y validación OCSP. |
| Suplantación de un usuario o aplicación | OAuth/IUA, MFA cuando corresponda, tokens firmados y validación de audiencia. |
| Acceso indebido a documentos | Autorización por usuario, paciente, rol, propósito, consentimiento y transacción. |
| Alteración del mensaje | TLS, firma X-Road, validación FHIR y verificación de integridad. |
| Repetición de solicitudes | Tokens breves, `jti`, identificadores únicos, controles de duplicados e idempotencia. |
| Enumeración de pacientes o documentos | Filtrado de respuestas, límites de frecuencia y política consistente de errores. |
| Extracción masiva de información | Paginación limitada, cuotas, detección de anomalías y alertas. |
| SSRF mediante URLs documentales | Lista de destinos permitidos, bloqueo de redes internas y validación de redirecciones. |
| Exposición de información en registros | Minimización, cifrado, control de acceso y política de retención. |
| Robo de credenciales o tokens | HTTPS, almacenamiento seguro, corta vigencia y rotación de secretos. |
| Denegación de servicio | Límites de tamaño, tiempo, frecuencia, concurrencia y monitoreo. |

#### Requisitos mínimos de conformidad

Una implementación conforme con esta guía debe, como mínimo:

1. utilizar HTTPS para todas las transacciones MHD;
2. autenticar al sistema consumidor;
3. autenticar al usuario cuando la operación sea iniciada por una persona;
4. autorizar cada transacción según usuario, organización, paciente y propósito;
5. aplicar permisos específicos para ITI-65, ITI-67 e ITI-68;
6. validar los recursos contra FHIR, MHD y los perfiles nacionales aplicables;
7. controlar las URLs utilizadas para recuperar documentos;
8. proteger documentos, respaldos y registros en reposo;
9. registrar accesos, búsquedas, publicaciones, recuperaciones y denegaciones;
10. correlacionar la auditoría de la aplicación con la evidencia de X-Road;
11. evitar que los errores revelen información clínica o técnica sensible; y
12. realizar análisis de riesgos y pruebas periódicas de seguridad.

#### Referencias

- [IHE MHD — Security Considerations](https://profiles.ihe.net/ITI/MHD/1335_security_considerations.html)
- [IHE MHD — Provide Document Bundle ITI-65](https://profiles.ihe.net/ITI/MHD/ITI-65.html)
- [IHE MHD — Find Document References ITI-67](https://profiles.ihe.net/ITI/MHD/ITI-67.html)
- [IHE MHD — Retrieve Document ITI-68](https://profiles.ihe.net/ITI/MHD/ITI-68.html)
- [IHE ITI — Mobile Security Considerations](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#Z.8)
- [IHE Internet User Authorization](https://profiles.ihe.net/ITI/IUA/index.html)
- [HL7 FHIR R4 — Security](https://hl7.org/fhir/R4/security.html)
- [HL7 FHIR R4 — AuditEvent](https://hl7.org/fhir/R4/auditevent.html)
- [HL7 FHIR R4 — Provenance](https://hl7.org/fhir/R4/provenance.html)
- [X-Road Security Architecture](https://docs.x-road.global/Architecture/arc-sec_x_road_security_architecture.html)
- [X-Road Message Protocol for REST](https://docs.x-road.global/Protocols/pr-rest_x-road_message_protocol_for_rest.html)

