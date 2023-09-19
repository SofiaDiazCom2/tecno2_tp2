
class Lanzamiento {

  float x, y;
  float angulo;
  float largo = 70;
  float ancho = 30;
  float diam = 20; // diam de pelota
  float velocidad = 1000; //velocidad del disparo

  float velocidadesX [];
  float velocidadesY [];

  float[] pesos;


  int cant = 10;


  int balasCreadas = 0; 
  float vel = 2;

  float tiempoUltimoDisparo = 0; 
  float tiempoEntreDisparos = 1000; 


  Lanzamiento(float x_, float y_) {

    x = x_;
    y = y_;

    velocidadesX = new float [cant];
    velocidadesY = new float [cant];

    for ( int i = 0; i < cant; i++) {
      velocidadesX[i] = velocidad * cos(angulo); 
      velocidadesY[i] = velocidad * sin(angulo);
    }

    pesos = new float[cant];
    for (int i = 0; i < cant; i++) {
      pesos[i] = random(0.8, 2.0); // Puedes ajustar los valores de peso según tus necesidades
    }


    angulo = radians(-90);
  }

  void dibujar() {
    pushMatrix();
    translate( x, y);
    rotate( angulo );
    fill(0, 255, 0);
    noStroke();
    rect(-ancho/2, -ancho/2, largo, ancho);
    popMatrix();
    image ( contador, 40, 50, 150, 38);
    println (mouseX, mouseY);
    textSize(14);
    fill(255);
    text(balasCreadas, 138, 73);
  }

  void teclado() {
    if (keyPressed) {

      if (keyCode == RIGHT) {
        angulo += radians(vel/2);
      } else if (keyCode == LEFT) {
        angulo-=radians(vel/2);
      } else if (key == ' ') {
        // Verificar si ha pasado suficiente tiempo desde el último disparo
        float tiempoActual = millis();
        if (tiempoActual - tiempoUltimoDisparo >= tiempoEntreDisparos) {
          l.disparar(mundo);
          tiempoUltimoDisparo = tiempoActual; // Actualizar el tiempo del último disparo
        }
      } 

      angulo = constrain( angulo, radians(-90), radians(0)); //El constrain es una RESTRICCIÓN (en este caso, entre menos 170 y menos 10)
    }
  }


  void disparar(FWorld mundo) { 
    
  pushStyle();


    if ( balasCreadas < 10) {

      FCircle bala = new FCircle( diam );
      bala.setPosition(x, y);
      bala.setFill(0, 0, 255);
      bala.setName("bala");

      float pesoBala = pesos[balasCreadas];
      float velocidadBala = velocidad / pesoBala;
      float vx = velocidadBala * cos(angulo);
      float vy = velocidadBala * sin(angulo);

      bala.setVelocity( vx, vy );
      mundo.add(bala);

      balasCreadas++;
    } else {
      estado = 3;
      
      popStyle();
    }

    //   void oscEvent(OscMessage m) {

    ////println(m);

    //if (m.addrPattern().equals("/annotations/palmBase")) {
    //  posX = map( m.get(0).floatValue(), 0, 800, width, 0 );
    //  posY = map( m.get(1).floatValue(), 0, 600, 0, height );
    //}
    //}
  }
}
