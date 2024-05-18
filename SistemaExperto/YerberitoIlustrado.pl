:- use_module(library(pce)).
:- consult('C:/SistemaExperto/hechos.pl').
:- consult('C:/SistemaExperto/plantas.pl').

consultar_enfermedad(Dialogo) :-
    new(DialogoConsulta, dialog('Consultar Enfermedad')),
    send(DialogoConsulta, append, new(TextoConsulta, text_item('Escribe la enfermedad:'))),
    send(DialogoConsulta, append, button('Aceptar', 
        message(@prolog, obtener_consulta_enfermedad, DialogoConsulta, TextoConsulta))),
    send(DialogoConsulta, append, button('Cancelar', 
        message(DialogoConsulta, destroy))),
    send(DialogoConsulta, open).

obtener_consulta_enfermedad(DialogoConsulta, TextoConsulta) :-
    get(TextoConsulta, selection, Enfermedad),
    consulta_enfermedad(Enfermedad, Hierbas),
    mostrar_resultado_hierbas(Hierbas).

consulta_enfermedad(Enfermedad, HierbasConSalto) :-
    findall(Hierba, hierba_para(Hierba, Enfermedad), Hierbas),
    add_newlines(Hierbas, HierbasConSalto).

add_newlines([], []).
add_newlines([Hierba|Hierbas], [HierbaConSalto|HierbasConSalto]) :-
    string_concat(Hierba, '\n', HierbaConSalto),
    add_newlines(Hierbas, HierbasConSalto).

mostrar_resultado_hierbas(Hierbas) :-
    new(Dialogo, dialog('Hierbas')),
    new(TextoResultado, text), 
    forall(member(Hierba, Hierbas),
           send(TextoResultado, append, Hierba)), 
    send(Dialogo, append, TextoResultado),  
    send(Dialogo, append, button('Cerrar', 
        message(Dialogo, destroy))),  
    send(Dialogo, open). 


consultar_planta(Dialogo) :-
    new(DialogoConsulta, dialog('Consultar planta')),
    send(DialogoConsulta, append, new(TextoConsulta, text_item('Escribe la planta:'))),
    send(DialogoConsulta, append, button('Aceptar', 
        message(@prolog, obtener_consulta_planta, DialogoConsulta, TextoConsulta))),
    send(DialogoConsulta, append, button('Cancelar', 
        message(DialogoConsulta, destroy))),
    send(DialogoConsulta, open).

obtener_consulta_planta(DialogoConsulta, TextoConsulta) :-
    get(TextoConsulta, selection, Planta),
    consulta_planta(Planta, Enfermedades),
    mostrar_resultado(Enfermedades).

consulta_planta(Planta, EnfermedadesConSalto) :-
    findall(Enfermedad, hierba_para(Planta, Enfermedad), Enfermedades),
    add_newlines(Enfermedades, EnfermedadesConSalto).

add_newlines([], []).
add_newlines([Enfermedad|Enfermedades], [EnfermedadConSalto|EnfermedadesConSalto]) :-
    string_concat(Enfermedad, '\n', EnfermedadConSalto),
    add_newlines(Enfermedades, EnfermedadesConSalto).

mostrar_resultado(Enfermedades) :-
    new(Dialogo, dialog('Enfermedades')),
    new(TextoResultado, text), 
    forall(member(Enfermedad, Enfermedades),
           send(TextoResultado, append, Enfermedad)), 
    send(Dialogo, append, TextoResultado),  
    send(Dialogo, append, button('Cerrar', 
        message(Dialogo, destroy))),  
    send(Dialogo, open). 

consultar_todas_plantas :-
    findall(Nombre, planta(Nombre), ListaPlantas),
    mostrar_lista_plantas(ListaPlantas).

mostrar_lista_plantas(ListaPlantas) :-
    new(Dialogo, dialog('Lista de Plantas')),
    new(Lista, list_browser),
    send(Lista, width, 50),  
    forall(member(Planta, ListaPlantas),
           send(Lista, append, dict_item(Planta))),
    send(Dialogo, append, Lista),
    send(Dialogo, append, button('Cerrar', message(Dialogo, destroy))),
    send(Dialogo, open).

mostrar(Ruta, Dialogo, Boton) :-
    new(I, image(Ruta)),
    new(B, bitmap(I)),
    new(F2, figure),
    send(F2, display, B),
    new(D1, device),
    send(D1, display, F2),
    send(Dialogo, display, D1),
    send(D1, below(Boton)).

plantas_medicamento :-
    new(Dialogo, dialog('Plantas que producen medicamentos')),
    new(Texto, text('Estas son algunas plantas que producen medicamentos:\n 
    - La planta DIGITAL produce la DIGITALINA.
    - El OPIO nos permite la existencia de la MORFINA y GODEINA.
    - La IPECA genera EMETINA para la disenteria, hemoptisis y hpatitis ambiana.
    - La NUEZ VOMICA produce ESTRICINA.
    - El ELEBORO BLANCO la VERATRINNA.
    - El COLCHICO genera COLQUICINA.
    - La BELLADORA hace ATROPINA.
    - La QUINA crea QUININA.
    - El CACAO la TEOBROMINA.
    - La RETAMA produce ESPARATEINA.
    - La COCA genera COCAINA.
    - El TEYOTE hace MESCALINA.
    - La EFEDRA crea EFEDRINA.
    - EL BARBASCO las HORMONAS.
    - El NENUFAR AMARILLO produce LUTENURINA.
    - El ÑAME la DIOSPONINA.
    - La ARTEMISA produce TANREMISNA.
    - La SEMILLA DE YUTE crea OLITORISIDA.
    - El TOLOACHE hace ACIDO LISERGICO.
    - El EUCALIPTO genera EUCALIPTOL.
    - El ROSAL nos da la VITAMINA C y la QUERCITRINA.\n')),
    send(Dialogo, append, Texto),
    Ruta1 = 'C:/SistemaExperto/imagenes/PLANTAS.jpeg', 
    mostrar(Ruta1, Dialogo, Texto),
    send(Dialogo, append, button('Cerrar', message(Dialogo, destroy))),
    send(Dialogo, open).

elementos_planta :-
    new(Dialogo, dialog('Elementos de las plantas')),
    new(Texto1, text('Las plantas tienen elementos generales como lo son:\n 
    - Vitaminas.
    - Hormonas.
    - Minerales.
    - Proteinas.
    - Oligoelementos.
    - Enzimas.
    - Alcaloides.\n
    Curiosamente todos estos elementos son utiles para tratar las enfermedades, veamos 2  ejemplos 
    de plantas y su contenido.\n
    El diente de Leon.
    Esta conformada por alcaloides denominados taraxacina e inulina, una resina soluble en alcohol 
    y otra en cloroformo, azucar, clorofila, acetato, oxalato de hierro, sulfato de calcio, clorivaro, 
    acetato de sodio, cilicato y aluminato de potasio.')),
    send(Dialogo, append, Texto1),
    Ruta1 = 'C:/SistemaExperto/imagenes/DIENTE_LEON.jpg', 
    mostrar(Ruta1, Dialogo, Texto1),
    new(Texto2, text('La manzanilla contiene.
    cloroila, azulina, tanatos, oxalatos, resina, aceite esencial y sustancia amarga.\n')),
    send(Dialogo, append, Texto2),
    Ruta2 = 'C:/SistemaExperto/imagenes/MANZANILLA.jpg', 
    mostrar(Ruta2, Dialogo, Texto2),
    send(Dialogo, append, button('Cerrar', message(Dialogo, destroy))),
    send(Dialogo, open).

botiquin_Plantas :-
    new(Dialogo, dialog('Botiquin de plantas')),
    new(Texto1, text('Para armar un botiquin hay plantas que nunca deben de faltar en el almacen, como lo son las siguientes:\n
    - Anis estrella.
    - Menta.
    - Arnica.
    - Salvia.
    - Tila.
    - Eucalipto.
    - Yerbabuena.
    - Manzanilla.
    - Cola de caballo.
    - Romero.
    - Toronjil.
    - Sanguinaria.
    - Linaza.
    - Hamamelis.
    - Zarzaparrilla.
    - Boldo.
    - Diente de leon.
    - Azahar.
    - Malva.
    - Marrubio.
    - Rosal.\n')),
    send(Dialogo, append, Texto1),
    Ruta1 = 'C:/SistemaExperto/imagenes/PLANTAS2.jpg', 
    mostrar(Ruta1, Dialogo, Texto1),
    send(Dialogo, append, button('Cerrar', message(Dialogo, destroy))),
    send(Dialogo, open).

preparar_Plantas :-
    new(Dialogo, dialog('Formas de preparar las plantas')),
    new(Texto1, text('Existen 7 formas para preparar las plantas:
    1.- Cocimiento:
        Poner a hervir en agua la hierba o raiz, por 10 minutos.
        Dejar reposar unos 5 minutos.
        Beberlo colado.
    2.- Infusion:
        Hervir el agua en un recipiente y vaciarla ya hervida y 
        todavia hirviendo a otro envase con la planta.
        Tapar y dejar en reposo 5 minutos.
        Colar y tomar.
    3.- Maceracion:
        Triturar la planta y sumergirla en poca agua para que suelte 
        las sustancias.
    4.- Jarabe:
        Hervir por 10 minutos en agua.
        Agregar Azucar (tanto y medio acorde al agua) y hervir 10 
        minutos.
        Ya frio se cuela y se agrega 10% de alcohol de caña.
        Se envasa para su uso posterior.
    5.- Tintura:
        En un frasco que pueda taparse por medio de un corcho, poner 
        la planta desmenzada  o triturada.
        Agregar alcohol de caña.
        Agitar y agregar agua destilada o de lluvia (25g por cada 75g
        de alcohol).
        Reposar en oscuridad una o dos semanas agitandolo de vez en 
        cuando.
        Filtrar con algodon o esponja y listo.
    6.- Jugo:
        Exprimir las plantas con un trapo limpio.
    7.- Horchata:
        Moler las semillas.
        Agregar poco a poco agua hasta formas una masa.
        Colar en un cedazo.
        Endulzar.
        Agregar agua para tomarla.')),
    send(Dialogo, append, Texto1),
    Ruta1 = 'C:/SistemaExperto/imagenes/REMEDIOS.jpg', 
    mostrar(Ruta1, Dialogo, Texto1),
    send(Dialogo, append, button('Cerrar', message(Dialogo, destroy))),
    send(Dialogo, open).

iniciar :-
    new(Dialogo, dialog('El yerberito ilustrado')),
    new(MenuBar, menu_bar),
    send(Dialogo, append, MenuBar),
    new(Menu, popup('Informacion de las plantas: ')),
    send(MenuBar, append, Menu),
    send_list(Menu, append,
              [ menu_item('Ver todas las plantas', message(@prolog, consultar_todas_plantas)),
                menu_item('Elementos de planta', message(@prolog, elementos_planta)),
                menu_item('Plantas que producen medicamentos', message(@prolog, plantas_medicamento)),
                menu_item('Botiquin de plantas', message(@prolog, botiquin_Plantas)),
                menu_item('Formas de preparar las plantas', message(@prolog, preparar_Plantas))
              ]),
    send(Dialogo, append, new(BotonPlanta, button('Buscar Planta'))),
    send(Dialogo, append, new(BotonEnfermedad, button('Buscar Enfermedad'))),
    new(Figura, figure),
    RutaAbsoluta = 'C:/SistemaExperto/imagenes/portada.jpg', 
    mostrar(RutaAbsoluta, Dialogo, BotonPlanta),
    send(Dialogo, open),
    send(BotonPlanta, message, message(@prolog, consultar_planta, Dialogo)), 
    send(BotonEnfermedad, message, message(@prolog, consultar_enfermedad, Dialogo)).
