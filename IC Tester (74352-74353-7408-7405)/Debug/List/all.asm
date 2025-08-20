
;CodeVisionAVR C Compiler V3.14 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega32A
;Program type           : Application
;Clock frequency        : 11.059200 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 512 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32A
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2048
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _x=R5
	.DEF _j=R4
	.DEF _intr=R7
	.DEF _counter=R8
	.DEF _counter_msb=R9
	.DEF _flag=R6
	.DEF _flag2=R11
	.DEF _flag3=R10
	.DEF _flag4=R13
	.DEF _actual_output=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  _ext_int1_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G101:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G101:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0

_0x11:
	.DB  0x6,0x7,0x0,0x1,0x2,0x3,0x4,0x5
	.DB  0x7,0x6,0x5,0x4,0x3,0x2,0x1,0x0
_0x1E:
	.DB  0x6,0x7,0x0,0x1,0x2,0x3,0x4,0x5
	.DB  0x7,0x6,0x5,0x4,0x3,0x2,0x1,0x0
_0x0:
	.DB  0x49,0x43,0x73,0x20,0x74,0x65,0x73,0x74
	.DB  0x65,0x64,0x3A,0x20,0x25,0x75,0x0,0x54
	.DB  0x65,0x73,0x74,0x69,0x6E,0x67,0x20,0x74
	.DB  0x68,0x65,0x20,0x49,0x43,0x0,0x49,0x43
	.DB  0x20,0x69,0x73,0x20,0x37,0x34,0x30,0x35
	.DB  0x20,0x0,0x49,0x43,0x20,0x69,0x73,0x20
	.DB  0x37,0x34,0x30,0x38,0x20,0x0,0x49,0x43
	.DB  0x20,0x69,0x73,0x20,0x37,0x34,0x33,0x35
	.DB  0x33,0x20,0x0,0x49,0x43,0x20,0x69,0x73
	.DB  0x20,0x37,0x34,0x33,0x35,0x32,0x20,0x0
	.DB  0x49,0x43,0x20,0x6E,0x6F,0x74,0x20,0x66
	.DB  0x6F,0x75,0x6E,0x64,0x20,0x0
_0x2000003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x08
	.DW  0x06
	.DW  __REG_VARS*2

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x260

	.CSEG
;/*******************
;This program was created by the
;CodeWizardAVR V3.12 Advanced
;Automatic Program Generator
;© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 12/31/2024
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega32A
;Program type            : Application
;AVR Core Clock frequency: 11.059200 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 512
;*******************/
;
;#include <mega32a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;// Alphanumeric LCD functions
;#include <alcd.h>
;#include <stdio.h>
;#include <delay.h>
;// Declare your global variables here
;
;unsigned char line[17];
;unsigned char x;
;signed char  j;
;unsigned char intr=0;     //Interrupt flag to indicate external interrupt occurrence
;int counter=0;           // Counter for counting interrupt events
;unsigned char  flag=0;    //flags for the IC tests
;unsigned char  flag2=0;
;unsigned char  flag3=0;
;unsigned char  flag4=0;
;unsigned char actual_output;      //to store the output values of the ICs
;unsigned char expected_output;    //to store the expected values from the ICs
;// External Interrupt 0 service routine
;interrupt [EXT_INT1] void ext_int1_isr(void)
; 0000 002D {

	.CSEG
_ext_int1_isr:
; .FSTART _ext_int1_isr
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0000 002E // Place your code here
; 0000 002F     unsigned int i , l,k;
; 0000 0030     //delay to avoid debounce
; 0000 0031 
; 0000 0032         intr=1;      //interrupt flag is raised
	CALL __SAVELOCR6
;	i -> R16,R17
;	l -> R18,R19
;	k -> R20,R21
	LDI  R30,LOW(1)
	MOV  R7,R30
; 0000 0033         counter++;    //counter increment
	MOVW R30,R8
	ADIW R30,1
	MOVW R8,R30
; 0000 0034 
; 0000 0035 }
	CALL __LOADLOCR6
	ADIW R28,6
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
; .FEND
;void and_gate(){
; 0000 0036 void and_gate(){
_and_gate:
; .FSTART _and_gate
; 0000 0037 
; 0000 0038     // Define pin mappings for the AND gate IC
; 0000 0039     #define INPUT1_1 0
; 0000 003A     #define INPUT2_1 1
; 0000 003B     #define OUTPUT1 2
; 0000 003C     #define INPUT1_2 3
; 0000 003D     #define INPUT2_2 4
; 0000 003E     #define OUTPUT2 5
; 0000 003F     #define GND 6
; 0000 0040 
; 0000 0041     #define VCC 0
; 0000 0042     #define INPUT1_3 1
; 0000 0043     #define INPUT2_3 2
; 0000 0044     #define OUTPUT3 3
; 0000 0045     #define INPUT1_4 4
; 0000 0046     #define INPUT2_4 5
; 0000 0047     #define OUTPUT4 6
; 0000 0048 
; 0000 0049 
; 0000 004A     unsigned char i = 0;
; 0000 004B     flag2=0;     // Reset error flag
	ST   -Y,R17
;	i -> R17
	LDI  R17,0
	CLR  R11
; 0000 004C 
; 0000 004D     // Configure pins as input or output for testing
; 0000 004E     DDRA |= (1<<INPUT1_1) | (1<<INPUT2_1) | (1<<INPUT1_2) | (1<<INPUT2_2) | (1<<GND);
	IN   R30,0x1A
	ORI  R30,LOW(0x5B)
	OUT  0x1A,R30
; 0000 004F     DDRC |= (1<<INPUT1_3) | (1<<INPUT2_3) | (1<<INPUT1_4) | (1<<INPUT2_4) | (1<<VCC);
	IN   R30,0x14
	ORI  R30,LOW(0x37)
	OUT  0x14,R30
; 0000 0050 
; 0000 0051     DDRA &= ~(1<<OUTPUT1);
	CBI  0x1A,2
; 0000 0052     DDRA &= ~(1<<OUTPUT2);
	CBI  0x1A,5
; 0000 0053     DDRC &= ~(1<<OUTPUT3);
	CBI  0x14,3
; 0000 0054     DDRC &= ~(1<<OUTPUT4);
	CBI  0x14,6
; 0000 0055     PORTA |= (1<<OUTPUT1) | (1<<OUTPUT2) ;
	IN   R30,0x1B
	ORI  R30,LOW(0x24)
	OUT  0x1B,R30
; 0000 0056     PORTC |= (1<<OUTPUT4)| (1<<OUTPUT3);
	IN   R30,0x15
	ORI  R30,LOW(0x48)
	OUT  0x15,R30
; 0000 0057     PORTA &=~(1<<GND);
	CBI  0x1B,6
; 0000 0058     PORTC |= (1<<VCC);
	SBI  0x15,0
; 0000 0059 
; 0000 005A     // Test Case 1: Apply HIGH to all inputs and test outputs
; 0000 005B     PORTA |= (1<<INPUT1_1) | (1<<INPUT2_1) | (1<<INPUT1_2) | (1<<INPUT2_2);
	IN   R30,0x1B
	ORI  R30,LOW(0x1B)
	OUT  0x1B,R30
; 0000 005C     PORTC |= (1<<INPUT1_3) | (1<<INPUT2_3) | (1<<INPUT1_4) | (1<<INPUT2_4);
	IN   R30,0x15
	ORI  R30,LOW(0x36)
	OUT  0x15,R30
; 0000 005D     if ((PINA.OUTPUT1) != 1){
	SBIC 0x19,2
	RJMP _0x3
; 0000 005E         flag2=1;     // Output error
	LDI  R30,LOW(1)
	MOV  R11,R30
; 0000 005F     }
; 0000 0060     if ((PINA.OUTPUT2) != 1){
_0x3:
	SBIC 0x19,5
	RJMP _0x4
; 0000 0061         flag2=1;    // Output error
	LDI  R30,LOW(1)
	MOV  R11,R30
; 0000 0062     }
; 0000 0063     if ((PINC.OUTPUT3) != 1){
_0x4:
	SBIC 0x13,3
	RJMP _0x5
; 0000 0064         flag2=1;    // Output error
	LDI  R30,LOW(1)
	MOV  R11,R30
; 0000 0065     }
; 0000 0066     if ((PINC.OUTPUT4) != 1){
_0x5:
	SBIC 0x13,6
	RJMP _0x6
; 0000 0067         flag2=1;    // Output error
	LDI  R30,LOW(1)
	MOV  R11,R30
; 0000 0068     }
; 0000 0069 
; 0000 006A      // Test Case 2: Apply LOW to all inputs and test outputs
; 0000 006B     PORTA &= ~(1<<INPUT1_1) ;
_0x6:
	CBI  0x1B,0
; 0000 006C     PORTA &= ~(1<<INPUT2_1) ;
	CBI  0x1B,1
; 0000 006D     PORTA &= ~(1<<INPUT1_2) ;
	CBI  0x1B,3
; 0000 006E     PORTA &= ~(1<<INPUT2_2) ;
	CBI  0x1B,4
; 0000 006F 
; 0000 0070     PORTC &= ~(1<<INPUT1_3) ;
	CBI  0x15,1
; 0000 0071     PORTC &= ~(1<<INPUT2_3) ;
	CBI  0x15,2
; 0000 0072     PORTC &= ~(1<<INPUT1_4) ;
	CBI  0x15,4
; 0000 0073     PORTC &= ~(1<<INPUT2_4) ;
	CBI  0x15,5
; 0000 0074     if ((PINA.OUTPUT1) != 0){
	SBIS 0x19,2
	RJMP _0x7
; 0000 0075         flag2=1;
	LDI  R30,LOW(1)
	MOV  R11,R30
; 0000 0076     }
; 0000 0077     if ((PINA.OUTPUT2) != 0){
_0x7:
	SBIS 0x19,5
	RJMP _0x8
; 0000 0078         flag2=1;
	LDI  R30,LOW(1)
	MOV  R11,R30
; 0000 0079     }
; 0000 007A     if ((PINC.OUTPUT3) != 0){
_0x8:
	SBIS 0x13,3
	RJMP _0x9
; 0000 007B         flag2=1;
	LDI  R30,LOW(1)
	MOV  R11,R30
; 0000 007C     }
; 0000 007D     if ((PINC.OUTPUT4) != 0){
_0x9:
	SBIS 0x13,6
	RJMP _0xA
; 0000 007E         flag2=1;
	LDI  R30,LOW(1)
	MOV  R11,R30
; 0000 007F     }
; 0000 0080 
; 0000 0081     // Test Case 3: Apply one LOW input and one HIGH input and test outputs
; 0000 0082     PORTA |= (1<<INPUT1_1) | (1<<INPUT1_2);
_0xA:
	IN   R30,0x1B
	ORI  R30,LOW(0x9)
	OUT  0x1B,R30
; 0000 0083     PORTA &= ~(1<<INPUT2_1);
	CBI  0x1B,1
; 0000 0084     PORTA &= ~(1<<INPUT2_2);
	CBI  0x1B,4
; 0000 0085 
; 0000 0086     PORTC |= (1<<INPUT1_3) | (1<<INPUT1_4);
	IN   R30,0x15
	ORI  R30,LOW(0x12)
	OUT  0x15,R30
; 0000 0087     PORTC &= ~(1<<INPUT2_3);
	CBI  0x15,2
; 0000 0088     PORTC &= ~(1<<INPUT2_4);
	CBI  0x15,5
; 0000 0089 
; 0000 008A     if ((PINA.OUTPUT1) != 0){
	SBIS 0x19,2
	RJMP _0xB
; 0000 008B         flag2=1;          // Output error
	LDI  R30,LOW(1)
	MOV  R11,R30
; 0000 008C     }
; 0000 008D     if ((PINA.OUTPUT2) != 0){
_0xB:
	SBIS 0x19,5
	RJMP _0xC
; 0000 008E         flag2=1;          // Output error
	LDI  R30,LOW(1)
	MOV  R11,R30
; 0000 008F     }
; 0000 0090     if ((PINC.OUTPUT3) != 0){
_0xC:
	SBIS 0x13,3
	RJMP _0xD
; 0000 0091         flag2=1;         // Output error
	LDI  R30,LOW(1)
	MOV  R11,R30
; 0000 0092     }
; 0000 0093     if ((PINC.OUTPUT4) != 0){
_0xD:
	SBIS 0x13,6
	RJMP _0xE
; 0000 0094         flag2=1;         // Output error
	LDI  R30,LOW(1)
	MOV  R11,R30
; 0000 0095     }
; 0000 0096 
; 0000 0097 }
_0xE:
	LD   R17,Y+
	RET
; .FEND
;void not_gate(){
; 0000 0098 void not_gate(){
_not_gate:
; .FSTART _not_gate
; 0000 0099 
; 0000 009A     // Define pin mappings for the NOT gate IC
; 0000 009B     #define INPUT1 0
; 0000 009C     #define OUTPUT1 1
; 0000 009D     #define INPUT2 2
; 0000 009E     #define OUTPUT2 3
; 0000 009F     #define INPUT3 4
; 0000 00A0     #define OUTPUT3 5
; 0000 00A1     #define INPUT4 1
; 0000 00A2     #define OUTPUT4 2
; 0000 00A3     #define GND 6
; 0000 00A4     #define INPUT5 3
; 0000 00A5     #define OUTPUT5 4
; 0000 00A6     #define INPUT6 5
; 0000 00A7     #define OUTPUT6 6
; 0000 00A8     #define VCC 0
; 0000 00A9 
; 0000 00AA 
; 0000 00AB     flag3=0;       // Reset error flag
	CLR  R10
; 0000 00AC 
; 0000 00AD     // Configure pins as input or output for testing
; 0000 00AE     DDRA |= (1<<INPUT1) | (1<<INPUT2) | (1<<INPUT3) | (1<<GND);
	IN   R30,0x1A
	ORI  R30,LOW(0x55)
	OUT  0x1A,R30
; 0000 00AF     DDRC |= (1<<INPUT4) | (1<<INPUT5) | (1<<INPUT6) | (1<<VCC);
	IN   R30,0x14
	ORI  R30,LOW(0x2B)
	OUT  0x14,R30
; 0000 00B0 
; 0000 00B1     DDRA &= ~(1<<OUTPUT1);
	CBI  0x1A,1
; 0000 00B2     DDRA &= ~(1<<OUTPUT2);
	CBI  0x1A,3
; 0000 00B3     DDRA &= ~(1<<OUTPUT3);
	CBI  0x1A,5
; 0000 00B4     DDRC &= ~(1<<OUTPUT4);
	CBI  0x14,2
; 0000 00B5     DDRC &= ~(1<<OUTPUT5);
	CBI  0x14,4
; 0000 00B6     DDRC &= ~(1<<OUTPUT6);
	CBI  0x14,6
; 0000 00B7     PORTA |= ( 1 << OUTPUT1) | ( 1 << OUTPUT2) | ( 1 << OUTPUT3);
	IN   R30,0x1B
	ORI  R30,LOW(0x2A)
	OUT  0x1B,R30
; 0000 00B8     PORTC |= ( 1 << OUTPUT4) | ( 1 << OUTPUT5) | ( 1 << OUTPUT6);
	IN   R30,0x15
	ORI  R30,LOW(0x54)
	OUT  0x15,R30
; 0000 00B9     PORTA &= ~(1<<GND);
	CBI  0x1B,6
; 0000 00BA     PORTC |= (1<<VCC);
	SBI  0x15,0
; 0000 00BB 
; 0000 00BC      // Test Case 1: Apply LOW to all inputs and test outputs
; 0000 00BD     PORTA &= ~((1 << INPUT1) | (1 << INPUT2) | (1 << INPUT3));
	IN   R30,0x1B
	ANDI R30,LOW(0xEA)
	OUT  0x1B,R30
; 0000 00BE     PORTC &= ~((1 << INPUT4) | (1 << INPUT5) | (1 << INPUT6));
	IN   R30,0x15
	ANDI R30,LOW(0xD5)
	CALL SUBOPT_0x0
; 0000 00BF 
; 0000 00C0     actual_output =
; 0000 00C1         (((PINA >> 1) & 0x01) << 0) |
; 0000 00C2         (((PINA >> 3) & 0x01) << 1) |
; 0000 00C3         (((PINA >> 5) & 0x01) << 2) |
; 0000 00C4         (((PINC >> 2) & 0x01) << 3) |
; 0000 00C5         (((PINC >> 4) & 0x01) << 4) |
; 0000 00C6         (((PINC >> 6) & 0x01) << 5);
; 0000 00C7     expected_output = 0x3F;
	LDI  R30,LOW(63)
	STS  _expected_output,R30
; 0000 00C8     if (actual_output != expected_output) {   //to check if all outputs are HIGH
	CP   R30,R12
	BREQ _0xF
; 0000 00C9         flag3=1;     // Output error
	LDI  R30,LOW(1)
	MOV  R10,R30
; 0000 00CA     }
; 0000 00CB     delay_ms(10);
_0xF:
	LDI  R26,LOW(10)
	LDI  R27,0
	CALL _delay_ms
; 0000 00CC 
; 0000 00CD      // Test Case 2: Apply HIGH to all inputs and test outputs
; 0000 00CE     PORTA |= ((1 << INPUT1) | (1 << INPUT2) | (1 << INPUT3));
	IN   R30,0x1B
	ORI  R30,LOW(0x15)
	OUT  0x1B,R30
; 0000 00CF     PORTC |= ((1 << INPUT4) | (1 << INPUT5) | (1 << INPUT6));
	IN   R30,0x15
	ORI  R30,LOW(0x2A)
	CALL SUBOPT_0x0
; 0000 00D0     actual_output =
; 0000 00D1         (((PINA >> 1) & 0x01) << 0) |
; 0000 00D2         (((PINA >> 3) & 0x01) << 1) |
; 0000 00D3         (((PINA >> 5) & 0x01) << 2) |
; 0000 00D4         (((PINC >> 2) & 0x01) << 3) |
; 0000 00D5         (((PINC >> 4) & 0x01) << 4) |
; 0000 00D6         (((PINC >> 6) & 0x01) << 5);
; 0000 00D7     expected_output = 0x00;
	LDI  R30,LOW(0)
	STS  _expected_output,R30
; 0000 00D8     if (actual_output != expected_output) {        //to check if all outputs are LOW
	CP   R30,R12
	BREQ _0x10
; 0000 00D9         flag3=1;      // Output error
	LDI  R30,LOW(1)
	MOV  R10,R30
; 0000 00DA     }
; 0000 00DB }
_0x10:
	RET
; .FEND
;void firstmux_ic(){
; 0000 00DC void firstmux_ic(){
_firstmux_ic:
; .FSTART _firstmux_ic
; 0000 00DD     // Define pin positions
; 0000 00DE     #define STROBE1 0
; 0000 00DF     #define INPUTB 1
; 0000 00E0     #define INPUT3 2
; 0000 00E1     #define INPUT2 3
; 0000 00E2     #define INPUT1 4
; 0000 00E3     #define INPUT0 5
; 0000 00E4     #define OUTPUTQ 6
; 0000 00E5     #define GND 7
; 0000 00E6 
; 0000 00E7     #define OUTPUTQ_2 7
; 0000 00E8     #define INPUT0_2 6
; 0000 00E9     #define INPUT1_2 5
; 0000 00EA     #define INPUT2_2 4
; 0000 00EB     #define INPUT3_2 3
; 0000 00EC     #define INPUTA 2
; 0000 00ED     #define STROBE2 1
; 0000 00EE     #define VCC 0
; 0000 00EF 
; 0000 00F0 
; 0000 00F1     unsigned char inputs[14] = {STROBE1, INPUTB, INPUT3, INPUT2, INPUT1, INPUT0, GND, INPUT0_2, INPUT1_2, INPUT2_2, INPU ...
; 0000 00F2     unsigned char outputs[2] = {OUTPUTQ, OUTPUTQ_2};
; 0000 00F3 
; 0000 00F4     unsigned char i,temp;
; 0000 00F5     unsigned char d;
; 0000 00F6 
; 0000 00F7     flag=0;       // Reset error flag
	SBIW R28,16
	LDI  R24,16
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x11*2)
	LDI  R31,HIGH(_0x11*2)
	CALL __INITLOCB
	CALL __SAVELOCR4
;	inputs -> Y+6
;	outputs -> Y+4
;	i -> R17
;	temp -> R16
;	d -> R19
	CLR  R6
; 0000 00F8 
; 0000 00F9     DDRA=0;
	CALL SUBOPT_0x1
; 0000 00FA     DDRC=0;
; 0000 00FB 
; 0000 00FC     // Configure inputs
; 0000 00FD     DDRA &= ~(1 << OUTPUTQ);
; 0000 00FE     DDRC &= ~(1 << OUTPUTQ_2);
; 0000 00FF     PORTA |= (1<<OUTPUTQ);
; 0000 0100     PORTC |= (1<<OUTPUTQ_2);
; 0000 0101 
; 0000 0102     DDRA |= (1 << STROBE1) | (1 << INPUTB) | (1 << INPUT3) | (1 << INPUT2) | (1 << INPUT1) | (1 << INPUT0) | (1 << GND);
; 0000 0103     DDRC |= (1 << INPUT0_2) | (1 << INPUT1_2) | (1 << INPUT2_2) | (1 << INPUT3_2) | (1 << INPUTA) | (1 << STROBE2) | (1  ...
; 0000 0104 
; 0000 0105     PORTA = 0;
; 0000 0106     PORTC = 0;
; 0000 0107     PORTA &= ~(1<<GND);
; 0000 0108     PORTC |= (1<<VCC);
; 0000 0109     PORTA |= (1<<STROBE1);
; 0000 010A     PORTC |= (1<<STROBE2);
; 0000 010B 
; 0000 010C     // Assign input values (use separate variables or arrays for runtime values)
; 0000 010D     d = 0b1001;
	LDI  R19,LOW(9)
; 0000 010E     for (i=0; i<2; i++){
	LDI  R17,LOW(0)
_0x13:
	CPI  R17,2
	BRSH _0x14
; 0000 010F 
; 0000 0110         //diffrent configurations depending on the value tested with
; 0000 0111         //start with first 4 inputs
; 0000 0112         if (d==9){
	CPI  R19,9
	BRNE _0x15
; 0000 0113             PORTA |= (1<< INPUT3) | (1<< INPUT0) ;
	IN   R30,0x1B
	ORI  R30,LOW(0x24)
	OUT  0x1B,R30
; 0000 0114             PORTA &= ~(1<< INPUT2);
	CBI  0x1B,3
; 0000 0115             PORTA &= ~(1<< INPUT1) ;
	CBI  0x1B,4
; 0000 0116         }
; 0000 0117         else {
	RJMP _0x16
_0x15:
; 0000 0118             PORTA &= ~(1<< INPUT3) ;
	CBI  0x1B,2
; 0000 0119             PORTA &= ~(1<< INPUT0) ;
	CBI  0x1B,5
; 0000 011A             PORTA |= (1<< INPUT2) | (1<< INPUT1) ;
	IN   R30,0x1B
	ORI  R30,LOW(0x18)
	OUT  0x1B,R30
; 0000 011B         }
_0x16:
; 0000 011C 
; 0000 011D         x=0;
	CLR  R5
; 0000 011E         //Enable A and B pins of IC
; 0000 011F         PORTA |= (1<<INPUTB) ;
	SBI  0x1B,1
; 0000 0120         PORTC |= (1<< INPUTA);
	CALL SUBOPT_0x2
; 0000 0121         PORTA &= ~(1<<STROBE1);      //activate the inverted input
; 0000 0122         delay_ms(2);
; 0000 0123         temp = (PINA.OUTPUTQ);      //store the output result
; 0000 0124         x = !temp;                  //store the complement of the output
	MOV  R30,R16
	CALL __LNEGB1
	CALL SUBOPT_0x3
; 0000 0125         PORTA |= (1<<STROBE1);       //deactivate the inverted input
; 0000 0126 
; 0000 0127         delay_ms(2);
; 0000 0128         //Enable B and disable A
; 0000 0129         PORTA |= (1<<INPUTB) ;
	SBI  0x1B,1
; 0000 012A         PORTC &= ~(1<< INPUTA);
	CALL SUBOPT_0x4
; 0000 012B         PORTA &= ~(1<<STROBE1);
; 0000 012C         delay_ms(2);
; 0000 012D         temp = (PINA.OUTPUTQ);
; 0000 012E         x = (x << 1) | (!temp);         //append to the variable the complement of the output
	CALL SUBOPT_0x3
; 0000 012F         PORTA |= (1<<STROBE1);
; 0000 0130 
; 0000 0131         delay_ms(2);
; 0000 0132         //Enable A and disable B
; 0000 0133         PORTA &= ~(1<<INPUTB) ;
	CBI  0x1B,1
; 0000 0134         PORTC |= (1<< INPUTA);
	CALL SUBOPT_0x2
; 0000 0135         PORTA &= ~(1<<STROBE1);
; 0000 0136         delay_ms(2);
; 0000 0137         temp = (PINA.OUTPUTQ);
; 0000 0138         x = (x << 1) | (!temp);        //append to the variable the complement of the output
	CALL SUBOPT_0x5
	CALL SUBOPT_0x3
; 0000 0139         PORTA |= (1<<STROBE1);
; 0000 013A 
; 0000 013B         delay_ms(2);
; 0000 013C         //Disable both
; 0000 013D         PORTA &= ~(1<<INPUTB) ;
	CBI  0x1B,1
; 0000 013E         PORTC &= ~(1<< INPUTA);
	CALL SUBOPT_0x4
; 0000 013F         PORTA &= ~(1<<STROBE1);
; 0000 0140         delay_ms(2);
; 0000 0141         temp = (PINA.OUTPUTQ);
; 0000 0142         x = (x << 1) | (!temp);        //append to the variable the complement of the output
	MOV  R5,R30
; 0000 0143         PORTA |= (1<<STROBE1);
	SBI  0x1B,0
; 0000 0144 
; 0000 0145         if (x != d){                  //Compare the values of the complement of the output with the input
	CP   R19,R5
	BREQ _0x17
; 0000 0146             flag=1;     // Output error
	LDI  R30,LOW(1)
	MOV  R6,R30
; 0000 0147             break;     //do not continue the loop
	RJMP _0x14
; 0000 0148         }
; 0000 0149         d=0b0110;
_0x17:
	LDI  R19,LOW(6)
; 0000 014A     }
	SUBI R17,-1
	RJMP _0x13
_0x14:
; 0000 014B 
; 0000 014C     d = 0b1001;
	LDI  R19,LOW(9)
; 0000 014D     for (i=0; i<2; i++){
	LDI  R17,LOW(0)
_0x19:
	CPI  R17,2
	BRSH _0x1A
; 0000 014E 
; 0000 014F         //Repeat the smae test for the second 4 inputs
; 0000 0150         if (d==9){
	CPI  R19,9
	BRNE _0x1B
; 0000 0151             PORTC |= (1<< INPUT3_2) | (1<< INPUT0_2) ;
	IN   R30,0x15
	ORI  R30,LOW(0x48)
	OUT  0x15,R30
; 0000 0152             PORTC &= ~(1<< INPUT2_2);
	CBI  0x15,4
; 0000 0153             PORTC &= ~(1<< INPUT1_2) ;
	CBI  0x15,5
; 0000 0154         }
; 0000 0155         else {
	RJMP _0x1C
_0x1B:
; 0000 0156             PORTC &= ~(1<< INPUT3_2) ;
	CBI  0x15,3
; 0000 0157             PORTC &= ~(1<< INPUT0_2) ;
	CBI  0x15,6
; 0000 0158             PORTC |= (1<< INPUT2_2) | (1<< INPUT1_2) ;
	IN   R30,0x15
	ORI  R30,LOW(0x30)
	OUT  0x15,R30
; 0000 0159         }
_0x1C:
; 0000 015A         x=0;
	CLR  R5
; 0000 015B 
; 0000 015C         PORTA |= (1<<INPUTB) ;
	SBI  0x1B,1
; 0000 015D         PORTC |= (1<< INPUTA);
	CALL SUBOPT_0x6
; 0000 015E         PORTC &= ~(1<<STROBE2);
; 0000 015F         delay_ms(2);
; 0000 0160         temp = (PINC.OUTPUTQ_2);
; 0000 0161         x = !temp;
	MOV  R30,R16
	CALL __LNEGB1
	CALL SUBOPT_0x7
; 0000 0162         PORTC |= (1<<STROBE2);
; 0000 0163 
; 0000 0164         delay_ms(2);
; 0000 0165         PORTA |= (1<<INPUTB) ;
	SBI  0x1B,1
; 0000 0166         PORTC &= ~(1<< INPUTA);
	CALL SUBOPT_0x8
; 0000 0167         PORTC &= ~(1<<STROBE2);
; 0000 0168         delay_ms(2);
; 0000 0169         temp = (PINC.OUTPUTQ_2);
; 0000 016A         x = (x << 1) | (!temp);
	CALL SUBOPT_0x7
; 0000 016B         PORTC |= (1<<STROBE2);
; 0000 016C 
; 0000 016D         delay_ms(2);
; 0000 016E         PORTA &= ~(1<<INPUTB) ;
	CBI  0x1B,1
; 0000 016F         PORTC |= (1<< INPUTA);
	CALL SUBOPT_0x6
; 0000 0170         PORTC &= ~(1<<STROBE2);
; 0000 0171         delay_ms(2);
; 0000 0172         temp = (PINC.OUTPUTQ_2);
; 0000 0173         x = (x << 1) | (!temp);
	CALL SUBOPT_0x5
	CALL SUBOPT_0x7
; 0000 0174         PORTC |= (1<<STROBE2);
; 0000 0175 
; 0000 0176         delay_ms(2);
; 0000 0177         PORTA &= ~(1<<INPUTB) ;
	CBI  0x1B,1
; 0000 0178         PORTC &= ~(1<< INPUTA);
	CALL SUBOPT_0x8
; 0000 0179         PORTC &= ~(1<<STROBE2);
; 0000 017A         delay_ms(2);
; 0000 017B         temp = (PINC.OUTPUTQ_2);
; 0000 017C         x = (x << 1) | (!temp);
	MOV  R5,R30
; 0000 017D         PORTC |= (1<<STROBE2);
	SBI  0x15,1
; 0000 017E 
; 0000 017F 
; 0000 0180         if (x != d){
	CP   R19,R5
	BREQ _0x1D
; 0000 0181             flag=1;
	LDI  R30,LOW(1)
	MOV  R6,R30
; 0000 0182             break;
	RJMP _0x1A
; 0000 0183         }
; 0000 0184         d=0b0110;
_0x1D:
	LDI  R19,LOW(6)
; 0000 0185     }
	SUBI R17,-1
	RJMP _0x19
_0x1A:
; 0000 0186 
; 0000 0187 }
	CALL __LOADLOCR4
	JMP  _0x2080002
; .FEND
;void secondmux_ic(){
; 0000 0188 void secondmux_ic(){
_secondmux_ic:
; .FSTART _secondmux_ic
; 0000 0189     // Define pin positions
; 0000 018A     #define STROBE1 0
; 0000 018B     #define INPUTB 1
; 0000 018C     #define INPUT3 2
; 0000 018D     #define INPUT2 3
; 0000 018E     #define INPUT1 4
; 0000 018F     #define INPUT0 5
; 0000 0190     #define OUTPUTQ 6
; 0000 0191     #define GND 7
; 0000 0192 
; 0000 0193     #define OUTPUTQ_2 7
; 0000 0194     #define INPUT0_2 6
; 0000 0195     #define INPUT1_2 5
; 0000 0196     #define INPUT2_2 4
; 0000 0197     #define INPUT3_2 3
; 0000 0198     #define INPUTA 2
; 0000 0199     #define STROBE2 1
; 0000 019A     #define VCC 0
; 0000 019B 
; 0000 019C 
; 0000 019D     unsigned char inputs[14] = {STROBE1, INPUTB, INPUT3, INPUT2, INPUT1, INPUT0, GND, INPUT0_2, INPUT1_2, INPUT2_2, INPU ...
; 0000 019E     unsigned char outputs[2] = {OUTPUTQ, OUTPUTQ_2};
; 0000 019F 
; 0000 01A0     unsigned char i,temp;
; 0000 01A1     unsigned char d;
; 0000 01A2 
; 0000 01A3     flag4=0;
	SBIW R28,16
	LDI  R24,16
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x1E*2)
	LDI  R31,HIGH(_0x1E*2)
	CALL __INITLOCB
	CALL __SAVELOCR4
;	inputs -> Y+6
;	outputs -> Y+4
;	i -> R17
;	temp -> R16
;	d -> R19
	CLR  R13
; 0000 01A4     DDRA=0;
	CALL SUBOPT_0x1
; 0000 01A5     DDRC=0;
; 0000 01A6 
; 0000 01A7     DDRA &= ~(1 << OUTPUTQ);
; 0000 01A8     DDRC &= ~(1 << OUTPUTQ_2);
; 0000 01A9     PORTA |= (1<<OUTPUTQ);
; 0000 01AA     PORTC |= (1<<OUTPUTQ_2);
; 0000 01AB 
; 0000 01AC     // Configure inputs
; 0000 01AD 
; 0000 01AE     DDRA |= (1 << STROBE1) | (1 << INPUTB) | (1 << INPUT3) | (1 << INPUT2) | (1 << INPUT1) | (1 << INPUT0) | (1 << GND);
; 0000 01AF     DDRC |= (1 << INPUT0_2) | (1 << INPUT1_2) | (1 << INPUT2_2) | (1 << INPUT3_2) | (1 << INPUTA) | (1 << STROBE2) | (1  ...
; 0000 01B0 
; 0000 01B1 
; 0000 01B2     PORTA = 0;
; 0000 01B3     PORTC = 0;
; 0000 01B4     PORTA &= ~(1<<GND);
; 0000 01B5     PORTC |= (1<<VCC);
; 0000 01B6     PORTA |= (1<<STROBE1);
; 0000 01B7     PORTC |= (1<<STROBE2);
; 0000 01B8 
; 0000 01B9 
; 0000 01BA     //Change the direction of the output pin to be an output to the microcontroller
; 0000 01BB     DDRA |= (1<<OUTPUTQ);
	SBI  0x1A,6
; 0000 01BC     PORTA |= (1<<OUTPUTQ);     //Write HIGH signal to it
	SBI  0x1B,6
; 0000 01BD     DDRA &= ~(1<<OUTPUTQ);     //Invert again
	CBI  0x1A,6
; 0000 01BE     PORTA |= (1<<OUTPUTQ);     //activate pull up
	SBI  0x1B,6
; 0000 01BF     if (PINA.OUTPUTQ != 1){    //check if the output is HIGH
	SBIC 0x19,6
	RJMP _0x1F
; 0000 01C0         flag4=1;   // Output error
	LDI  R30,LOW(1)
	MOV  R13,R30
; 0000 01C1     }
; 0000 01C2     //Repeat the same test with a LOW signal
; 0000 01C3     DDRA |= (1<<OUTPUTQ);
_0x1F:
	SBI  0x1A,6
; 0000 01C4     PORTA &= ~(1<<OUTPUTQ);
	CBI  0x1B,6
; 0000 01C5     DDRA &= ~(1<<OUTPUTQ);
	CBI  0x1A,6
; 0000 01C6     PORTA |= (1<<OUTPUTQ);
	SBI  0x1B,6
; 0000 01C7     if (PINA.OUTPUTQ != 0){
	SBIS 0x19,6
	RJMP _0x20
; 0000 01C8         flag4=1;
	LDI  R30,LOW(1)
	MOV  R13,R30
; 0000 01C9     }
; 0000 01CA 
; 0000 01CB     //Repeat the same test for the second output
; 0000 01CC     DDRC |= (1<<OUTPUTQ_2);
_0x20:
	SBI  0x14,7
; 0000 01CD     PORTC |= (1<<OUTPUTQ_2);
	SBI  0x15,7
; 0000 01CE     DDRC &= ~(1<<OUTPUTQ_2);
	CBI  0x14,7
; 0000 01CF     PORTC |= (1<<OUTPUTQ_2);
	SBI  0x15,7
; 0000 01D0     if (PINC.OUTPUTQ_2 != 1)
	SBIC 0x13,7
	RJMP _0x21
; 0000 01D1         flag4=1;
	LDI  R30,LOW(1)
	MOV  R13,R30
; 0000 01D2     DDRC |= (1<<OUTPUTQ_2);
_0x21:
	SBI  0x14,7
; 0000 01D3     PORTC &= ~(1<<OUTPUTQ_2);
	CBI  0x15,7
; 0000 01D4     DDRC &= ~(1<<OUTPUTQ_2);
	CBI  0x14,7
; 0000 01D5     PORTC |= (1<<OUTPUTQ_2);
	SBI  0x15,7
; 0000 01D6     if (PINC.OUTPUTQ != 0)
	SBIS 0x13,6
	RJMP _0x22
; 0000 01D7         flag4=1;
	LDI  R30,LOW(1)
	MOV  R13,R30
; 0000 01D8 }
_0x22:
	CALL __LOADLOCR4
	JMP  _0x2080002
; .FEND
;
;
;
;void main(void)
; 0000 01DD {
_main:
; .FSTART _main
; 0000 01DE // Declare your local variables here
; 0000 01DF 
; 0000 01E0 // Input/Output Ports initialization
; 0000 01E1 // Port A initialization
; 0000 01E2 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 01E3 DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0000 01E4 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 01E5 PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0000 01E6 
; 0000 01E7 // Port B initialization
; 0000 01E8 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 01E9 DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (1<<DDB2) | (1<<DDB1) | (0<<DDB0);
	LDI  R30,LOW(6)
	OUT  0x17,R30
; 0000 01EA // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 01EB PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 01EC 
; 0000 01ED // Port C initialization
; 0000 01EE // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 01EF DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
	OUT  0x14,R30
; 0000 01F0 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 01F1 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	OUT  0x15,R30
; 0000 01F2 
; 0000 01F3 // Port D initialization
; 0000 01F4 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 01F5 DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0x11,R30
; 0000 01F6 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 01F7 PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (1<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(8)
	OUT  0x12,R30
; 0000 01F8 
; 0000 01F9 // External Interrupt(s) initialization
; 0000 01FA // INT0: On
; 0000 01FB // INT0 Mode: Falling Edge
; 0000 01FC // INT1: Off
; 0000 01FD // INT2: Off
; 0000 01FE GICR|=(1<<INT1) | (0<<INT0) | (0<<INT2);
	IN   R30,0x3B
	ORI  R30,0x80
	OUT  0x3B,R30
; 0000 01FF MCUCR=(0<<ISC11) | (0<<ISC10) | (1<<ISC01) | (0<<ISC00);
	LDI  R30,LOW(2)
	OUT  0x35,R30
; 0000 0200 MCUCSR=(0<<ISC2);
	LDI  R30,LOW(0)
	OUT  0x34,R30
; 0000 0201 GIFR=(1<<INTF1) | (0<<INTF0) | (0<<INTF2);
	LDI  R30,LOW(128)
	OUT  0x3A,R30
; 0000 0202 
; 0000 0203 // Alphanumeric LCD initialization
; 0000 0204 // Connections are specified in the
; 0000 0205 // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 0206 // RS - PORTD Bit 0
; 0000 0207 // RD - PORTD Bit 1
; 0000 0208 // EN - PORTD Bit 2
; 0000 0209 // D4 - PORTD Bit 4
; 0000 020A // D5 - PORTD Bit 5
; 0000 020B // D6 - PORTD Bit 6
; 0000 020C // D7 - PORTD Bit 7
; 0000 020D // Characters/line: 16
; 0000 020E lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 020F 
; 0000 0210 // Global enable interrupts
; 0000 0211 #asm("sei")
	sei
; 0000 0212 
; 0000 0213 lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 0214 
; 0000 0215 while (1)
_0x23:
; 0000 0216       {
; 0000 0217       // Place your code here
; 0000 0218       lcd_init(16);        //LCD initialize
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 0219       lcd_clear();
	RCALL _lcd_clear
; 0000 021A       while(intr==0){    //while no interrupt signal recieved
_0x26:
	TST  R7
	BRNE _0x28
; 0000 021B         lcd_gotoxy(0,0);
	CALL SUBOPT_0x9
; 0000 021C         sprintf(line, "ICs tested: %u", counter);       //print the number of tested ICs
	__POINTW1FN _0x0,0
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R8
	CALL __CWD1
	CALL __PUTPARD1
	LDI  R24,4
	CALL _sprintf
	ADIW R28,8
; 0000 021D         lcd_puts(line);
	CALL SUBOPT_0xA
; 0000 021E       }
	RJMP _0x26
_0x28:
; 0000 021F       if (intr){
	TST  R7
	BRNE PC+2
	RJMP _0x29
; 0000 0220           lcd_clear();
	CALL SUBOPT_0xB
; 0000 0221           lcd_gotoxy(0,0);
; 0000 0222           sprintf(line, "Testing the IC");
	__POINTW1FN _0x0,15
	CALL SUBOPT_0xC
; 0000 0223           lcd_puts(line);
; 0000 0224           delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	CALL _delay_ms
; 0000 0225 
; 0000 0226           not_gate();                //call the NOT gate function
	RCALL _not_gate
; 0000 0227           if (flag3==0){             // check the flag
	TST  R10
	BRNE _0x2A
; 0000 0228             lcd_clear();
	CALL SUBOPT_0xB
; 0000 0229             lcd_gotoxy(0,0);
; 0000 022A             sprintf(line, "IC is 7405 ");      //if the flag is clear print the number of IC
	__POINTW1FN _0x0,30
	CALL SUBOPT_0xC
; 0000 022B             lcd_puts(line);
; 0000 022C             delay_ms(2000);
	CALL SUBOPT_0xD
; 0000 022D           }
; 0000 022E 
; 0000 022F           and_gate();               //call the AND gate function
_0x2A:
	RCALL _and_gate
; 0000 0230           if (flag2==0){
	TST  R11
	BRNE _0x2B
; 0000 0231             lcd_clear();
	CALL SUBOPT_0xB
; 0000 0232             lcd_gotoxy(0,0);
; 0000 0233             sprintf(line, "IC is 7408 ");
	__POINTW1FN _0x0,42
	CALL SUBOPT_0xC
; 0000 0234             lcd_puts(line);
; 0000 0235             delay_ms(2000);
	CALL SUBOPT_0xD
; 0000 0236           }
; 0000 0237 
; 0000 0238           firstmux_ic();              //call the first mux function
_0x2B:
	RCALL _firstmux_ic
; 0000 0239           if (flag==0){               //to check the IC flag if clear
	TST  R6
	BRNE _0x2C
; 0000 023A             secondmux_ic();           //call the second mux function as the are the same I/O test with an adddition to t ...
	RCALL _secondmux_ic
; 0000 023B             if (flag4==0){
	TST  R13
	BRNE _0x2D
; 0000 023C                 lcd_clear();
	CALL SUBOPT_0xB
; 0000 023D                 lcd_gotoxy(0,0);
; 0000 023E                 sprintf(line, "IC is 74353 ");     //if the test passed without errors print on the LCD the no. of secon ...
	__POINTW1FN _0x0,54
	RJMP _0x31
; 0000 023F                 lcd_puts(line);
; 0000 0240                 delay_ms(2000);
; 0000 0241             }
; 0000 0242             else{
_0x2D:
; 0000 0243                 lcd_clear();
	CALL SUBOPT_0xB
; 0000 0244                 lcd_gotoxy(0,0);
; 0000 0245                 sprintf(line, "IC is 74352 ");      //if not then the IC is the first one
	__POINTW1FN _0x0,67
_0x31:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _sprintf
	ADIW R28,4
; 0000 0246                 lcd_puts(line);
	CALL SUBOPT_0xA
; 0000 0247                 delay_ms(2000);
	CALL SUBOPT_0xD
; 0000 0248             }
; 0000 0249           }
; 0000 024A 
; 0000 024B           if (flag==1 & flag2==1 & flag3==1 & flag4==1){          //if the IC is none of the ones listed
_0x2C:
	MOV  R26,R6
	LDI  R30,LOW(1)
	CALL __EQB12
	MOV  R0,R30
	MOV  R26,R11
	LDI  R30,LOW(1)
	CALL __EQB12
	AND  R0,R30
	MOV  R26,R10
	LDI  R30,LOW(1)
	CALL __EQB12
	AND  R0,R30
	MOV  R26,R13
	LDI  R30,LOW(1)
	CALL __EQB12
	AND  R30,R0
	BREQ _0x2F
; 0000 024C             lcd_clear();
	CALL SUBOPT_0xB
; 0000 024D             lcd_gotoxy(0,0);
; 0000 024E             sprintf(line, "IC not found ");                      //unkown IC msg appears
	__POINTW1FN _0x0,80
	CALL SUBOPT_0xC
; 0000 024F             lcd_puts(line);
; 0000 0250             delay_ms(2000);
	CALL SUBOPT_0xD
; 0000 0251           }
; 0000 0252           intr=0;                //clear the interrupt flag
_0x2F:
	CLR  R7
; 0000 0253       }
; 0000 0254 
; 0000 0255 
; 0000 0256       }
_0x29:
	RJMP _0x23
; 0000 0257 }
_0x30:
	RJMP _0x30
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
; .FSTART __lcd_write_nibble_G100
	ST   -Y,R26
	IN   R30,0x12
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	LD   R30,Y
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x12,R30
	__DELAY_USB 18
	SBI  0x12,2
	__DELAY_USB 18
	CBI  0x12,2
	__DELAY_USB 18
	RJMP _0x2080003
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
	__DELAY_USB 184
	RJMP _0x2080003
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R30,Y+1
	STS  __lcd_x,R30
	LD   R30,Y
	STS  __lcd_y,R30
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0xE
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0xE
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	STS  __lcd_x,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2000005
	LDS  R30,__lcd_maxx
	LDS  R26,__lcd_x
	CP   R26,R30
	BRLO _0x2000004
_0x2000005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R26,__lcd_y
	SUBI R26,-LOW(1)
	STS  __lcd_y,R26
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2000007
	RJMP _0x2080003
_0x2000007:
_0x2000004:
	LDS  R30,__lcd_x
	SUBI R30,-LOW(1)
	STS  __lcd_x,R30
	SBI  0x12,0
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x12,0
	RJMP _0x2080003
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2000008:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x200000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2000008
_0x200000A:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	IN   R30,0x11
	ORI  R30,LOW(0xF0)
	OUT  0x11,R30
	SBI  0x11,2
	SBI  0x11,0
	SBI  0x11,1
	CBI  0x12,2
	CBI  0x12,0
	CBI  0x12,1
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0xF
	CALL SUBOPT_0xF
	CALL SUBOPT_0xF
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 276
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x2080003:
	ADIW R28,1
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_put_buff_G101:
; .FSTART _put_buff_G101
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x2020010
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2020012
	__CPWRN 16,17,2
	BRLO _0x2020013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2020012:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
_0x2020013:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x2020014
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
_0x2020014:
	RJMP _0x2020015
_0x2020010:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2020015:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
; .FEND
__print_G101:
; .FSTART __print_G101
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2020016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2020018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x202001C
	CPI  R18,37
	BRNE _0x202001D
	LDI  R17,LOW(1)
	RJMP _0x202001E
_0x202001D:
	CALL SUBOPT_0x10
_0x202001E:
	RJMP _0x202001B
_0x202001C:
	CPI  R30,LOW(0x1)
	BRNE _0x202001F
	CPI  R18,37
	BRNE _0x2020020
	CALL SUBOPT_0x10
	RJMP _0x20200CC
_0x2020020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2020021
	LDI  R16,LOW(1)
	RJMP _0x202001B
_0x2020021:
	CPI  R18,43
	BRNE _0x2020022
	LDI  R20,LOW(43)
	RJMP _0x202001B
_0x2020022:
	CPI  R18,32
	BRNE _0x2020023
	LDI  R20,LOW(32)
	RJMP _0x202001B
_0x2020023:
	RJMP _0x2020024
_0x202001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2020025
_0x2020024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2020026
	ORI  R16,LOW(128)
	RJMP _0x202001B
_0x2020026:
	RJMP _0x2020027
_0x2020025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x202001B
_0x2020027:
	CPI  R18,48
	BRLO _0x202002A
	CPI  R18,58
	BRLO _0x202002B
_0x202002A:
	RJMP _0x2020029
_0x202002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x202001B
_0x2020029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x202002F
	CALL SUBOPT_0x11
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x12
	RJMP _0x2020030
_0x202002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2020032
	CALL SUBOPT_0x11
	CALL SUBOPT_0x13
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2020033
_0x2020032:
	CPI  R30,LOW(0x70)
	BRNE _0x2020035
	CALL SUBOPT_0x11
	CALL SUBOPT_0x13
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2020033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2020036
_0x2020035:
	CPI  R30,LOW(0x64)
	BREQ _0x2020039
	CPI  R30,LOW(0x69)
	BRNE _0x202003A
_0x2020039:
	ORI  R16,LOW(4)
	RJMP _0x202003B
_0x202003A:
	CPI  R30,LOW(0x75)
	BRNE _0x202003C
_0x202003B:
	LDI  R30,LOW(_tbl10_G101*2)
	LDI  R31,HIGH(_tbl10_G101*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x202003D
_0x202003C:
	CPI  R30,LOW(0x58)
	BRNE _0x202003F
	ORI  R16,LOW(8)
	RJMP _0x2020040
_0x202003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2020071
_0x2020040:
	LDI  R30,LOW(_tbl16_G101*2)
	LDI  R31,HIGH(_tbl16_G101*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x202003D:
	SBRS R16,2
	RJMP _0x2020042
	CALL SUBOPT_0x11
	CALL SUBOPT_0x14
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2020043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2020043:
	CPI  R20,0
	BREQ _0x2020044
	SUBI R17,-LOW(1)
	RJMP _0x2020045
_0x2020044:
	ANDI R16,LOW(251)
_0x2020045:
	RJMP _0x2020046
_0x2020042:
	CALL SUBOPT_0x11
	CALL SUBOPT_0x14
_0x2020046:
_0x2020036:
	SBRC R16,0
	RJMP _0x2020047
_0x2020048:
	CP   R17,R21
	BRSH _0x202004A
	SBRS R16,7
	RJMP _0x202004B
	SBRS R16,2
	RJMP _0x202004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x202004D
_0x202004C:
	LDI  R18,LOW(48)
_0x202004D:
	RJMP _0x202004E
_0x202004B:
	LDI  R18,LOW(32)
_0x202004E:
	CALL SUBOPT_0x10
	SUBI R21,LOW(1)
	RJMP _0x2020048
_0x202004A:
_0x2020047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x202004F
_0x2020050:
	CPI  R19,0
	BREQ _0x2020052
	SBRS R16,3
	RJMP _0x2020053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2020054
_0x2020053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2020054:
	CALL SUBOPT_0x10
	CPI  R21,0
	BREQ _0x2020055
	SUBI R21,LOW(1)
_0x2020055:
	SUBI R19,LOW(1)
	RJMP _0x2020050
_0x2020052:
	RJMP _0x2020056
_0x202004F:
_0x2020058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x202005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x202005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x202005A
_0x202005C:
	CPI  R18,58
	BRLO _0x202005D
	SBRS R16,3
	RJMP _0x202005E
	SUBI R18,-LOW(7)
	RJMP _0x202005F
_0x202005E:
	SUBI R18,-LOW(39)
_0x202005F:
_0x202005D:
	SBRC R16,4
	RJMP _0x2020061
	CPI  R18,49
	BRSH _0x2020063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2020062
_0x2020063:
	RJMP _0x20200CD
_0x2020062:
	CP   R21,R19
	BRLO _0x2020067
	SBRS R16,0
	RJMP _0x2020068
_0x2020067:
	RJMP _0x2020066
_0x2020068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2020069
	LDI  R18,LOW(48)
_0x20200CD:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x202006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x12
	CPI  R21,0
	BREQ _0x202006B
	SUBI R21,LOW(1)
_0x202006B:
_0x202006A:
_0x2020069:
_0x2020061:
	CALL SUBOPT_0x10
	CPI  R21,0
	BREQ _0x202006C
	SUBI R21,LOW(1)
_0x202006C:
_0x2020066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2020059
	RJMP _0x2020058
_0x2020059:
_0x2020056:
	SBRS R16,0
	RJMP _0x202006D
_0x202006E:
	CPI  R21,0
	BREQ _0x2020070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x12
	RJMP _0x202006E
_0x2020070:
_0x202006D:
_0x2020071:
_0x2020030:
_0x20200CC:
	LDI  R17,LOW(0)
_0x202001B:
	RJMP _0x2020016
_0x2020018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
_0x2080002:
	ADIW R28,20
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0x15
	SBIW R30,0
	BRNE _0x2020072
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080001
_0x2020072:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	CALL SUBOPT_0x15
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G101)
	LDI  R31,HIGH(_put_buff_G101)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G101
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x2080001:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET
; .FEND

	.CSEG

	.CSEG
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND

	.DSEG
_line:
	.BYTE 0x11
_expected_output:
	.BYTE 0x1
__base_y_G100:
	.BYTE 0x4
__lcd_x:
	.BYTE 0x1
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:52 WORDS
SUBOPT_0x0:
	OUT  0x15,R30
	IN   R30,0x19
	LDI  R31,0
	ASR  R31
	ROR  R30
	ANDI R30,LOW(0x1)
	MOV  R26,R30
	IN   R30,0x19
	LDI  R31,0
	CALL __ASRW3
	ANDI R30,LOW(0x1)
	LSL  R30
	OR   R30,R26
	MOV  R26,R30
	IN   R30,0x19
	LDI  R31,0
	ASR  R31
	ROR  R30
	CALL __ASRW4
	ANDI R30,LOW(0x1)
	LSL  R30
	LSL  R30
	OR   R30,R26
	MOV  R26,R30
	IN   R30,0x13
	LDI  R31,0
	CALL __ASRW2
	ANDI R30,LOW(0x1)
	LSL  R30
	LSL  R30
	LSL  R30
	OR   R30,R26
	MOV  R26,R30
	IN   R30,0x13
	LDI  R31,0
	CALL __ASRW4
	ANDI R30,LOW(0x1)
	SWAP R30
	ANDI R30,0xF0
	OR   R30,R26
	MOV  R26,R30
	IN   R30,0x13
	LDI  R31,0
	CALL __ASRW2
	CALL __ASRW4
	ANDI R30,LOW(0x1)
	SWAP R30
	ANDI R30,0xF0
	LSL  R30
	OR   R30,R26
	MOV  R12,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x1:
	LDI  R30,LOW(0)
	OUT  0x1A,R30
	OUT  0x14,R30
	CBI  0x1A,6
	CBI  0x14,7
	SBI  0x1B,6
	SBI  0x15,7
	IN   R30,0x1A
	ORI  R30,LOW(0xBF)
	OUT  0x1A,R30
	IN   R30,0x14
	ORI  R30,LOW(0x7F)
	OUT  0x14,R30
	LDI  R30,LOW(0)
	OUT  0x1B,R30
	OUT  0x15,R30
	CBI  0x1B,7
	SBI  0x15,0
	SBI  0x1B,0
	SBI  0x15,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x2:
	SBI  0x15,2
	CBI  0x1B,0
	LDI  R26,LOW(2)
	LDI  R27,0
	CALL _delay_ms
	LDI  R30,0
	SBIC 0x19,6
	LDI  R30,1
	MOV  R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x3:
	MOV  R5,R30
	SBI  0x1B,0
	LDI  R26,LOW(2)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x4:
	CBI  0x15,2
	CBI  0x1B,0
	LDI  R26,LOW(2)
	LDI  R27,0
	CALL _delay_ms
	LDI  R30,0
	SBIC 0x19,6
	LDI  R30,1
	MOV  R16,R30
	MOV  R30,R5
	LSL  R30
	MOV  R26,R30
	MOV  R30,R16
	LDI  R31,0
	CALL __LNEGW1
	OR   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x5:
	MOV  R30,R5
	LSL  R30
	MOV  R26,R30
	MOV  R30,R16
	LDI  R31,0
	CALL __LNEGW1
	OR   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6:
	SBI  0x15,2
	CBI  0x15,1
	LDI  R26,LOW(2)
	LDI  R27,0
	CALL _delay_ms
	LDI  R30,0
	SBIC 0x13,7
	LDI  R30,1
	MOV  R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x7:
	MOV  R5,R30
	SBI  0x15,1
	LDI  R26,LOW(2)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x8:
	CBI  0x15,2
	CBI  0x15,1
	LDI  R26,LOW(2)
	LDI  R27,0
	CALL _delay_ms
	LDI  R30,0
	SBIC 0x13,7
	LDI  R30,1
	MOV  R16,R30
	RJMP SUBOPT_0x5

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:39 WORDS
SUBOPT_0x9:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
	LDI  R30,LOW(_line)
	LDI  R31,HIGH(_line)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xA:
	LDI  R26,LOW(_line)
	LDI  R27,HIGH(_line)
	JMP  _lcd_puts

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xB:
	CALL _lcd_clear
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0xC:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R24,0
	CALL _sprintf
	ADIW R28,4
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xD:
	LDI  R26,LOW(2000)
	LDI  R27,HIGH(2000)
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xF:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G100
	__DELAY_USW 276
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x10:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x11:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x12:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x13:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x14:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x15:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0xACD
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ASRW4:
	ASR  R31
	ROR  R30
__ASRW3:
	ASR  R31
	ROR  R30
__ASRW2:
	ASR  R31
	ROR  R30
	ASR  R31
	ROR  R30
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__EQB12:
	CP   R30,R26
	LDI  R30,1
	BREQ __EQB12T
	CLR  R30
__EQB12T:
	RET

__LNEGB1:
	TST  R30
	LDI  R30,1
	BREQ __LNEGB1F
	CLR  R30
__LNEGB1F:
	RET

__LNEGW1:
	OR   R30,R31
	LDI  R30,1
	BREQ __LNEGW1F
	LDI  R30,0
__LNEGW1F:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	ADD  R26,R28
	ADC  R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:
