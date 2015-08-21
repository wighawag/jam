package;

import ys.Input;
import kha.Framebuffer;

import cosmos.CosmosPresenter;

import ys.sprite.Sprites;

interface CosmosKhaPresenter extends CosmosPresenter{
  public function render(elapsedTime : Float, frame:Framebuffer) : Void;
  public function setSprites(sprites:Sprites): Void;
}
