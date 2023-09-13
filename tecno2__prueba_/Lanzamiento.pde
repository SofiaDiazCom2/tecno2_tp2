class Lanzamiento {

  float x, y;
  float angulo;
  float largo = 70;
  float ancho = 30;
  float diam = 20; // diam de pelota
  float velocidad = 1000; //velocidad del disparo
  int cant = 10;
  
  float amortiguacion = 0.9;


  int balasCreadas = 0; 
  float vel = 2;


float tiempoUltimoDisparo = 0; 
float tiempoEntreDisparos = 1000; 


  Lanzamiento(float x_, float y_) {

    x = x_;
    y = y_;

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
      if (tiempoActual - tiempoUltimoDisparo >= tiempoEntreDisparos && seTocan && up) {
        l.disparar(mundo);
        tiempoUltimoDisparo = tiempoActual; // Actualizar el tiempo del último disparo
      }
      } 

      angulo = constrain( angulo, radians(-90), radians(0)); //El constrain es una RESTRICCIÓN (en este caso, entre menos 170 y menos 10)
    }
  }


  void disparar(FWorld mundo) { 

    if ( balasCreadas < 10) {

      FCircle bala = new FCircle( diam );
      bala.setPosition(x, y);
      bala.setFill(0, 0, 255);
      bala.setName("bala");

      float vx = velocidad * cos(angulo);
      float vy = velocidad * sin (angulo);

      bala.setVelocity( vx, vy );
      mundo.add(bala);

      balasCreadas++;
    } else {
      estado = 4;
    }
    
     void oscEvent(OscMessage m) {

  //println(m);
  
  if (m.addrPattern().equals("/annotations/palmBase")) {
    posX = map( m.get(0).floatValue(), 0, 800, width, 0 );
    posY = map( m.get(1).floatValue(), 0, 600, 0, height );
  }
  }
}
