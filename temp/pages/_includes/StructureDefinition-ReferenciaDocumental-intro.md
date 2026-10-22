###  Propósito

El perfil `ReferenciaDocumental` se utiliza para registrar los metadatos de un documento clínico y señalar dónde puede recuperarse su contenido. Está derivado de `MinimalDocumentReference` de IHE MHD y está pensado para escenarios de publicación, búsqueda y recuperación documental relacionados con las transacciones ITI-65, ITI-67 e ITI-68.

El recurso `DocumentReference` **no es necesariamente el documento clínico**. Es principalmente un índice o registro de metadatos que permite:

- identificar de manera única el documento;
- conocer el paciente, autor, fecha, tipo y categoría;
- conocer el formato técnico del contenido;
- localizar el documento mediante `content.attachment.url`;
- verificar opcionalmente la integridad del contenido mediante `content.attachment.hash`.

En este perfil, el contenido se maneja **por referencia**: el documento no se incorpora codificado dentro del `DocumentReference`, sino que se obtiene desde la ubicación indicada en `attachment.url`.
