# procesar_texto

Script `.bat` para Windows que convierte el contenido de un archivo `.txt`
a mayúsculas y extrae automáticamente campos clave como Nombre, Teléfono,
Origen, Destino y Referencia.

## Requisitos

- Windows 7 o superior
- No requiere PowerShell ni programas adicionales

## Uso

1. Coloca `procesar_texto.bat` en la misma carpeta que tu archivo `.txt`
2. Haz doble clic en `procesar_texto.bat`
3. El script detecta automáticamente el `.txt` y genera dos archivos nuevos:

| Archivo generado | Contenido |
|---|---|
| `nombre_MAYUSCULAS.txt` | Texto completo convertido a mayúsculas |
| `nombre_DATOS.txt` | Resumen con los campos extraídos |

## Campos que extrae

- `Nombre`
- `Teléfono` / `Tel` / `Móvil` / `Celular`
- `Origen` / `Desde`
- `Destino` / `Hasta`
- `Referencia`

## Formato del archivo de entrada

El `.txt` debe seguir este formato:

```
**Nombre:** Juan García
**Teléfono:** 612 345 678
**Origen:** Madrid
**Destino:** Barcelona
**Referencia:** 123
```

## Importante

El archivo `procesar_texto.bat` debe estar guardado en codificación
**ANSI / Windows-1252** (no UTF-8) para que las letras acentuadas
(á, é, í, ó, ú, ñ) se conviertan correctamente a mayúsculas.

En el Bloc de notas: Archivo → Guardar como → Codificación: ANSI

## Autor

javiermorron
