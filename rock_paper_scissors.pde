import java.util.ArrayList;
import java.util.Random;


public class Ensamble{
  private int x, y,r,total;
  private ArrayList<ArrayList<Integer>> points = new ArrayList<ArrayList<Integer>>();
  private Random randomGenerator = new Random();
  
  public Ensamble(int x, int y, int total, int r){
    this.x = x;
    this.y = y;
    this.r = r;
    this.total = total;
    this.generate();
  }
  
  private void generate(){
    ArrayList<Integer> startingPoint = new ArrayList<Integer>();
    startingPoint.add(this.x);
    startingPoint.add(this.y);
    this.points.add(startingPoint);
    
    
    
    int minX = this.x-this.r < 0 ? 0 : this.x-this.r;
    int maxX = this.x+this.r;
    int minY = this.y-this.r < 0 ? 0 : this.y-this.r;
    int maxY = this.y+this.r;

    
    for(Integer i = 0; i < this.total-1; i++){
      Integer randomX = this.randomGenerator.nextInt(maxX-minX+1)+minX;
      Integer randomY = this.randomGenerator.nextInt(maxY-minY+1)+minY;
      
      ArrayList<Integer> point = new ArrayList<Integer>();
      point.add(randomX);
      point.add(randomY);
    
      this.points.add(point);
    }
    
  }
  
  public ArrayList<ArrayList<Integer>> getPoints(){
    return this.points;
  }
  
  public void updatePoints(Integer increment){
    for(Integer i = 0; i < this.total; i++){
      Integer dir = this.randomGenerator.nextInt(5);
      
      ArrayList<Integer> point = this.points.get(i);
      Integer xValue = point.get(0);
      Integer yValue = point.get(1);
      Integer newValue = 0;


      switch(dir){
        case 0:
          if(xValue > 0){
            if(xValue-increment > 0){
              newValue = xValue-increment;
            }else{
              newValue = 0;
            }
            point.set(0, newValue);
          }
          break;

          
        case 1:
          if(xValue < width){
              if(xValue+increment < width){
                  newValue = xValue+increment;
              }else{
                newValue = width;
              }
              point.set(0, newValue);
          }
          break;

          
        case 2:
          if(yValue > 0){
              if(yValue-increment > 0){
                  newValue = yValue-increment;
              }else{
                newValue = 0;
              }
              point.set(1, newValue);
          }
          break;

          
        case 3:
          if(yValue < height){
              if(yValue+increment < height){
                  newValue = yValue+increment;
              }else{
                newValue = height;
              }
              point.set(1, newValue);
          }
          break;
        default:
          break;
      }
      
    }
  }
  
  public void addPoint(ArrayList<Integer> point){
    this.points.add(point);
    this.total++;
  }
  
  public void removePoint(ArrayList<Integer> point){
    this.points.remove(point);
    this.total--;
  }
}

public class Player{
  private PImage image;
  private Ensamble points;
  
  public Player(PImage image, Ensamble points){
    this.image = image;
    this.points = points;
  }
  
  public void render(){
    for(ArrayList<Integer> point : this.points.getPoints()){
      image(this.image, point.get(0), point.get(1));
    }
  }
  
  public void updatePoints(){
    this.points.updatePoints(30);
  }
  
  public void addPoint(ArrayList<Integer> point){
    this.points.addPoint(point);
  }
  
  public void removePoint(ArrayList<Integer> point){
    this.points.removePoint(point);
  }
}


Player rock, paper, scissors;
Integer counter = 0;

void setup(){
  size(800, 600);
  PImage rock_image = loadImage("assets/rock.png");
  PImage paper_image = loadImage("assets/paper.png");
  PImage scissors_image = loadImage("assets/scissors.png");
  
  rock  = new Player(rock_image, new Ensamble(10, 10, 20, 100));
  paper  = new Player(paper_image, new Ensamble(500, 100, 20, 90));
  scissors  = new Player(scissors_image, new Ensamble(400, 400, 20, 100));
  
}

void draw(){
  background(255, 255 ,255);
  rock.render();
  paper.render();
  scissors.render();
  
  if(counter%6 == 0){
    counter = 0;
    rock.updatePoints();
    paper.updatePoints();
    scissors.updatePoints();
    checkCollision();
  }  
  
  counter ++;
}


ArrayList<Integer> deepcopy(ArrayList<Integer> list){
   ArrayList<Integer> newList = new ArrayList<Integer>();
   newList.add(list.get(0));
   newList.add(list.get(1));
   return newList;
}

void checkCollision(){
  //rock with scissors
  ArrayList<ArrayList<Integer>> newRocks = new ArrayList<ArrayList<Integer>>();
  ArrayList<Integer> scissorsIndex = new ArrayList<Integer>();
  
  for(ArrayList<Integer> rockPoint : rock.points.getPoints()){
      Integer i = 0;
      for(ArrayList<Integer> scissorsPoint : scissors.points.getPoints()){
        double d = Math.sqrt(Math.pow(rockPoint.get(0) - scissorsPoint.get(0),2) + Math.pow(rockPoint.get(1) - scissorsPoint.get(1),2));
        if(d <= 20 && !scissorsIndex.contains(i)){
           newRocks.add(scissorsPoint);
           scissorsIndex.add(i);
        }
        i++;
      }
  }
  
  for(ArrayList<Integer> newRock : newRocks){
    rock.addPoint(deepcopy(newRock));
    scissors.removePoint(newRock);
  }
  
  //scissors with paper
  ArrayList<ArrayList<Integer>> newScissorsList = new ArrayList<ArrayList<Integer>>();
  ArrayList<Integer> paperIndex = new ArrayList<Integer>();
  
  for(ArrayList<Integer> scissorsPoint : scissors.points.getPoints()){
      Integer i = 0;
      for(ArrayList<Integer> PaperPoint : paper.points.getPoints()){
        double d = Math.sqrt(Math.pow(scissorsPoint.get(0) - PaperPoint.get(0),2) + Math.pow(scissorsPoint.get(1) - PaperPoint.get(1),2));
        if(d <= 20 && !paperIndex.contains(i)){
          newScissorsList.add(PaperPoint);
          paperIndex.add(i);
        }
        i++;
      }
  }
  
  for(ArrayList<Integer> newScissors : newScissorsList){
    scissors.addPoint(deepcopy(newScissors));
    paper.removePoint(newScissors);
  }
  
  
  //paper with rock
  ArrayList<ArrayList<Integer>> newPapers = new ArrayList<ArrayList<Integer>>();
  ArrayList<Integer> rockIndex = new ArrayList<Integer>();
  
  for(ArrayList<Integer> paperPoint : paper.points.getPoints()){
      Integer i = 0;
      for(ArrayList<Integer> rockPoint : rock.points.getPoints()){
        double d = Math.sqrt(Math.pow(paperPoint.get(0) - rockPoint.get(0),2) + Math.pow(paperPoint.get(1) - rockPoint.get(1),2));
        if(d <= 20 && !rockIndex.contains(i)){
          newPapers.add(rockPoint);
          rockIndex.add(i);
        }        
        i++;
      }
  }
  
  for(ArrayList<Integer> newPaper : newPapers){
    paper.addPoint(deepcopy(newPaper));
    rock.removePoint(newPaper);
  }

}
