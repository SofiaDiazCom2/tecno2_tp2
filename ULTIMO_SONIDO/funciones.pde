int contadorDeColisiones = 0;

void contactStarted(FContact colision) {
    if ( hayColisionEntre( colision, "bala", "enemigo")) {
      FBody uno = colision.getBody1();
      contadorDeColisiones++;

      if (anchoBarra < 202) {
        miSonido2.play();
        miSonido2.amp(0.2);
        anchoBarra += 40;
      }

      if (contadorDeColisiones >= 5) {
        //mundo.remove( dos );
        mundo.remove( uno );
        //contadorDeColisiones = 0;
        //anchoBarra = 0;
        ganaste = true;
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
    //enemigo.attachImage(oveja);
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
