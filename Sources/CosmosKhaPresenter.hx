package;

import ys.Input;
import kha.Framebuffer;

import cosmos.CosmosPresenter;

interface CosmosKhaPresenter extends CosmosPresenter{
  public function render(elapsedTime : Float, frame:Framebuffer, input : Input) : Void;
}
