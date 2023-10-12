int contadorDeColisiones = 0;


void contactStarted( FContact colision) {


  if ( hayColisionEntre( colision, "bala", "enemigo")) {

    //FBody uno = colision.getBody1();
    FBody dos = colision.getBody2();

    contadorDeColisiones++;
    mundo.remove(dos);  // Eliminar la bala cuando colisiona con el pastor

    if (anchoBarra < 200) {

      anchoBarra += 40;
    }


    if (contadorDeColisiones >= 5 && anchoBarra >= 200) {
      // Hacer lo que necesitas cuando ganas
      Viento.stop();
      Ganaste.play();
      Ganaste.amp(0.4);
      contadorDeColisiones = 0;
      anchoBarra = 0;
      estado = 2;  // Cambiar al estado de ganar
    }
  }





  if ( hayColisionEntre( colision, "bala", "biblia")) {
    
    FBody dos = colision.getBody2();
    mundo.remove(dos);  // Eliminar la bala cuando colisiona con la biblia
    contadorDeColisiones++;
    
    if (contadorDeColisiones >= 6) {
      // Desaparecer la Biblia
      mundo.remove(b.cuadrado); // Suponiendo que "cuadrado" representa la Biblia
      // Resto de las acciones que desees realizar cuando la Biblia desaparezca

      bibliaDesaparecida = true;
    }
    if (bibliaDesaparecida == true ) {
      Viento.play();
      Viento.amp(0.5);
      Viento.loop();
    }
  }
}


boolean hayColisionEntre(FContact contact, String nombreUno, String nombreDos) {
  boolean resultado = false;
  FBody uno = contact.getBody1();
  FBody dos = contact.getBody2();
  String etiquetaUno = uno.getName();
  String etiquetaDos = dos.getName();

  if (etiquetaUno != null && etiquetaDos != null) {
    if ((nombreUno.equals(etiquetaUno) && nombreDos.equals(etiquetaDos)) ||
      (nombreDos.equals(etiquetaUno) && nombreUno.equals(etiquetaDos))) {
      resultado = true;
    }
  }
  return resultado;
}

void agregarEnemigo() {
  FBox enemigo = new FBox(74, 125);
  enemigo.setPosition(685, 365);
  enemigo.setStatic(true);
  enemigo.setName("enemigo");
  enemigo.setNoFill();
  enemigo.setNoStroke();
  mundo.add(enemigo);
}

void borrarBalas() {
  ArrayList<FBody> cuerpos = mundo.getBodies();
  for (FBody este : cuerpos) {
    String nombre = este.getName();
    if (nombre != null) {
      if (nombre.equals("bala")) {
        if (este.getY() > height + 100) {
          mundo.remove(este);
        }
      }
    }
  }
}
