class Biblia{
  
  // CÓDIGO DII

FBox cuadrado;
float velocidad = 8; // Velocidad de movimiento
PImage imagen; // Variable para cargar la imagen

boolean moviendoHaciaArriba = true; // Controla la dirección del movimiento vertical
boolean moviendoHaciaDerecha = false; // Controla la dirección del movimiento horizontal
float targetX, targetY; // Posición objetivo para el MouseJoint


  
  Biblia(){
    //CÓDIGO DII

  cuadrado = new FBox(140, 150);
  cuadrado.setPosition(width / 2 + 250, height + cuadrado.getHeight() / 2 ); // Iniciar desde abajo
  cuadrado.setStatic(false); // Permitir que el cuadrado sea afectado por la gravedad
  cuadrado.setDensity(0.1);
  cuadrado.setFriction(0.5);
  cuadrado.setRestitution(0.5);

  // Cargar y asignar la imagen como textura del cuadrado
  imagen = loadImage("holyBible.png");
  cuadrado.attachImage(imagen);
  imagen.resize(int(cuadrado.getWidth()), int(cuadrado.getHeight()));

  // Agregar cuadrado al mundo
  mundo.add(cuadrado);

  // Inicializar la posición objetivo
  targetX = cuadrado.getX();
  targetY = height / 2; // Mover hacia la mitad de la pantalla


  }
  
  void dibujar(){
    
     //CÓDIGO DII ==> ANIMACIÓN BIBLIA

    // Verificar si el cuadrado llegó al límite derecho
    if (cuadrado.getX() >= width + cuadrado.getWidth() / 2) {
      // Reiniciar la trayectoria
      cuadrado.setPosition(width / 2 + 250, height + cuadrado.getHeight() / 2); // Iniciar desde abajo
      cuadrado.setStatic(true); // Permitir que el cuadrado sea afectado por la gravedad
      cuadrado.setDensity(0.1);
      cuadrado.setFriction(0.5);
      cuadrado.setRestitution(0.5);
      targetX = cuadrado.getX();
      targetY = height / 2; // Mover hacia la mitad de la pantalla
      velocidad = 4;
      moviendoHaciaArriba = false;
      moviendoHaciaDerecha = false;

      //PRUEBA CON CHAT GPT

      cuadrado.setVelocity(0, 0);
      targetX = cuadrado.getX();
      targetY = height / 2;
      
      // Verificar si el cuadrado llegó a la mitad de la pantalla
    
    }

// Actualizar la posición del cuadrado hacia el objetivo
    float dx = targetX - cuadrado.getX();
    float dy = targetY - cuadrado.getY();
    float distancia = sqrt(dx * dx + dy * dy);

    // Limitar la velocidad de movimiento
    if (distancia > velocidad) {
      dx = (dx / distancia) * velocidad;
      dy = (dy / distancia) * velocidad;
    }
    
    // Verificar si el cuadrado llegó a la mitad de la pantalla
    if (cuadrado.getY() <= height / 2) {
      targetX = width + cuadrado.getWidth() / 2; // Mover hacia el límite derecho
    }



    cuadrado.setPosition(cuadrado.getX() + dx, cuadrado.getY() + dy);

    // Dibujar el cuadrado
    fill(0, 150, 255);
    image(imagen, cuadrado.getX(), cuadrado.getY(), cuadrado.getWidth(), cuadrado.getHeight());


  }
}
