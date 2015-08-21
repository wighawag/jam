package;

import kha.Framebuffer;

using Khage;
import kha.Color;
import cosmos.Entities;
import comp.Placement;
import comp.State;
import comp.Asset;
import comp.ColorComp;

import ys.sprite.Sprites;

class RectanglesAndSpritesPresenter implements CosmosKhaPresenter{

  var rectangles : Entities<{placement:Placement, color : ColorComp}>;
  var sprites : Entities<{placement:Placement, state: State, asset : Asset}>;

  var spriting : Sprites;

  public function setSprites(spriting : Sprites){
      this.spriting = spriting;
  }

  public function render(elapsedTime : Float, frame:Framebuffer) : Void{
    frame.usingG2({
			g2.clear();

      for(rectangle in rectangles){
        var placement = rectangle.placement;
        g2.color = rectangle.color.color;
        g2.drawRect(placement.x, placement.y, placement.width, placement.height);
      }

      g2.color = Color.White;
      if(spriting != null){
        for(sprite in sprites){
          var placement = sprite.placement;
          var state = sprite.state;
          var asset = sprite.asset;

          spriting.draw(g2,asset.id,state.state,state.getElapsedTime(elapsedTime),placement.x,placement.y, placement.width, placement.height, true);
        }
      }



		 });

  }
}
