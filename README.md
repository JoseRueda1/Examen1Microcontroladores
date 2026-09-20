# Examen1Microcontroladores
# FSM Semáforo con Cruce Peatonal

Proyecto de Arquitectura de Computadoras — Universidad del Istmo de Guatemala.
Máquina de estados finitos (7 estados) que controla un semáforo vehicular con cruce peatonal, factorizada en una máquina **Moore** (ciclo de luces) y una máquina **Mealy** (cruce peatonal), diseñadas para interactuar entre sí.

---

## Parcial 1 — Diseño en Logisim

Diseño, construcción y simulación completa de la FSM en Logisim-evolution, siguiendo el procedimiento de diseño de 7 pasos: identificación de entradas/salidas, diagrama de transición, tabla de transición, codificación de estados, tabla codificada, ecuaciones booleanas, y esquemático.

**Contenido:**
- 7 estados (verde/amarillo/rojo por cada calle + 2 estados de todo-rojo de transición + modo nocturno intermitente)
- Factorización: `moore_semaforo_block` (Moore) + `mealy_peatonal_block` (Mealy)
- LEDs de colores (rojo/amarillo/verde) y relojes automáticos para simulación autónoma

**Archivos:**
- `Parcial_1_Microcontroladores_Jose_Rueda.circ` — proyecto completo de Logisim

**Video:** https://youtu.be/luIZ3fh1mDE

---

## Parcial 2 — Migración a HDL y Timing Analysis

Incluye las tres partes solicitadas: Timing Analysis, migración a SystemVerilog con simulación en Vivado, y discusión de RTL Analysis / Synthesis / Implementation.

### Parte 1 — Timing Analysis
Cálculo de la frecuencia máxima de operación y cumplimiento de la restricción de hold para el tramo entre la FSM Moore y la FSM Mealy, usando componentes lógicos reales de la familia **74HC** (Texas Instruments / Digikey).

**Resultado:** Fmax ≈ 6.85 MHz (limitado por la restricción de setup en la ruta NOT→AND-4→OR-2).

**Archivos:**
- `Timing_Analysis_FSM.pdf` — documento completo con capturas de Logisim, capturas de Digikey y sus datasheets, diagrama de secuencia de tiempo, contamination delay, y cálculos de setup/hold

### Parte 2 — HDL (SystemVerilog)
Migración discreta de la lógica de la FSM a SystemVerilog, siguiendo la jerarquía:

top.sv
├── moore.sv (FSM Moore — ciclo de luces del semáforo)
└── mealy.sv (FSM Mealy — cruce peatonal)


**Archivos:**
- `top.sv`, `moore.sv`, `mealy.sv`
- `testbench.sv` — banco de pruebas, simulado en Vivado (verifica el ciclo completo de estados y la reacción instantánea de `Walk` ante el botón `P`)

### Parte 3 — RTL Analysis, Synthesis e Implementation
Discusión sobre cómo Vivado materializa el código HDL a componentes físicos, corriendo las 3 etapas sobre el diseño (parte `xc7a35tcpg236-1`, cubierta por la licencia gratuita WebPACK).

**Video (Parcial 2 completo — Timing Analysis, HDL/simulación, y discusión RTL/Synthesis/Implementation):** [enlace pendiente]

---

## Autor
José Rueda — Ingeniería en Sistemas, Universidad del Istmo de Guatemala
