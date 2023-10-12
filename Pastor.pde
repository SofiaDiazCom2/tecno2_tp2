class Pastor extends FBox {

  ArrayList <PImage> fotos;
  ArrayList <PImage> perros;
  int cont = 0;
  String estado = "normal";
  int vida;

  // Variable para controlar la velocidad de cambio de imágenes
  int velocidadCambioImagen = 100; // Ajusta la velocidad según tus necesidades
  int tiempoUltimaCambioImagen = 0;
  int imagenActual = 0;


  boolean enMundo = false;

  Pastor() {

    super(100, 200);

    setName("pastor");
    //setNoFill();
    //setNoStroke();

    fotos = new ArrayList();
    perros = new ArrayList();
    


    for ( int i=0; i<7; i++ ) {
      PImage estaFoto = loadImage("pastor" + i + ".png");
      fotos.add( estaFoto );
    }

    for ( int i=0; i<4; i++ ) {
      PImage estePerro = loadImage("Auch" + i + ".png");
      perros.add( estePerro );
    }

    imagenActual = 0;
    
  }

  void dibujar() {
  push();
  imageMode(CENTER);
  
  if (estado.equals("normal")) {
    if (millis() - tiempoUltimaCambioImagen >= velocidadCambioImagen) {
      imagenActual = (imagenActual + 1) % fotos.size();
      tiempoUltimaCambioImagen = millis();
    }

    PImage imagen = fotos.get(imagenActual);
    image(imagen, getX(), getY());
  } else if (estado.equals("golpeado")) {
    // Dibujar imágenes de perros
    if (imagenActual < perros.size()) {
      PImage perroImagen = perros.get(imagenActual);
      image(perroImagen, getX(), getY());
      imagenActual = (imagenActual + 1) % perros.size();
    } else {
      // Todas las imágenes de perros se han mostrado, cambiar a estado normal
      estado = "normal";
      imagenActual = 0;
    }
  }
  pop();
}


  void cambiarAImagenPerros() {
    estado = "golpeado";
    imagenActual = 0; // Reiniciar el contador de imágenes
  }


  void serGolpeado() {
    if (vida > 1) {
      vida--;
    } else {
      vida--;
      cambiarAImagenPerros(); // Cambiar a las imágenes de perros
    }
  }
}
