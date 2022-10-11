
class SurvivalModeCard_Scene

  # Waits x frames
  def wait(frames)
    frames.times do
      Graphics.update
    end
  end

  def pbUpdate
    pbUpdateSpriteHash(@sprites)
    if @sprites["bg"]
      @sprites["bg"].ox -= 2
      @sprites["bg"].oy -= 2
    end
  end

  def pbStartScene(vari=false)
    @front      = true
    @flip       = false
    @viewport   = Viewport.new(0,0,Graphics.width,Graphics.height)
    @viewport.z = 99999
    @sprites    = {}
    addBackgroundPlane(@sprites,"bg","Trainer Card/bg",@viewport)
    cardexists = pbResolveBitmap(sprintf("Graphics/Pictures/Trainer Card/card_f"))
    @sprites["card"] = IconSprite.new(0, 0, @viewport)
    if $player.female? && cardexists
      @sprites["card"].setBitmap("Graphics/Pictures/Trainer Card/card_f")
    else
      @sprites["card"].setBitmap("Graphics/Pictures/Trainer Card/card")
    end
    @sprites["overlay"] = BitmapSprite.new(Graphics.width, Graphics.height, @viewport)
    pbSetSystemFont(@sprites["overlay"].bitmap)
    @sprites["trainer"] = IconSprite.new(336, 112, @viewport)
    @sprites["trainer"].setBitmap(GameData::TrainerType.player_front_sprite_filename($player.trainer_type))
    @sprites["trainer"].x -= (@sprites["trainer"].bitmap.width - 128) / 2
    @sprites["trainer"].y -= (@sprites["trainer"].bitmap.height - 128)
    @sprites["trainer"].z = 2
     pbDrawSurvivalCard
    pbFadeInAndShow(@sprites) { pbUpdate }
	end
  end



  def pbDrawSurvivalCard
    overlay = @sprites["overlay"].bitmap
    overlay.clear
    baseColor   = Color.new(72, 72, 72)
    shadowColor = Color.new(160, 160, 160)
    totalsec = $stats.play_time.to_i
    hour = totalsec / 60 / 60
    min = totalsec / 60 % 60
    time = (hour > 0) ? _INTL("{1}h {2}m", hour, min) : _INTL("{1}m", min)

    if $player.playerhealth >= 80
         trainerhealth = _INTL("Healthy")
         healthColor=Color.new(255,255,255)
     else
       if $player.playerhealth >= 50
         trainerhealth = _INTL("Injured")
         healthColor=Color.new(255,255,255)
     else
        if $player.playerhealth >= 25
         trainerhealth = _INTL("Wounded")
         healthColor=Color.new(255,255,255)
     else
        if $player.playerhealth <= 24
         trainerhealth = _INTL("Critical")
         healthColor=Color.new(255,255,255)
        end
        end
     end
    end

    if $player.playerfood >= 80
         trainerhunger = _INTL("Full")
         hungerColor=Color.new(55,255,55)
       else
         if $player.playerfood >= 75
           trainerhunger = _INTL("Well Off")
           hungerColor=Color.new(255,255,55)
         else
           if $player.playerfood >= 50
             trainerhunger = _INTL("Hungry")
             hungerColor=Color.new(255,125,55)
           else
               if $player.playerfood >= 25
                trainerhunger = _INTL("Starving")
                hungerColor=Color.new(255,125,55)
                else
                 if $player.playerfood <= 24
                   trainerhunger= _INTL("Dying")
                   hungerColor=Color.new(255,55,55)
			    end
			   end
           end
         end
       end   


    if $player.playerwater >= 80
         trainerthirst = _INTL("Quenched")
         thirstColor=Color.new(55,255,55)
       else
         if $player.playerwater >= 75
           trainerthirst = _INTL("Well Off")
           thirstColor=Color.new(255,255,55)
         else
           if $player.playerwater >= 50
             trainerthirst = _INTL("Thirsty")
             thirstColor=Color.new(255,125,55)
           else
               if $player.playerwater >= 25
                trainerthirst = _INTL("Dehydrated")
                thirstColor=Color.new(255,125,55)
                else
                 if $player.playerwater <= 24
                   trainerthirst= _INTL("Dying")
                   thirstColor=Color.new(255,55,55)
			    end
			   end
           end
         end
       end   

    if $player.playersleep >= 80
          trainersleep = _INTL("Rested")
          sleepColor=Color.new(55,255,55)
       else
         if $player.playersleep >= 75
            trainersleep = _INTL("Well Off")
            sleepColor=Color.new(255,255,55)
         else
           if $player.playersleep >= 50
              trainersleep = _INTL("Tired")
              sleepColor=Color.new(255,125,55)
           else
               if $player.playersleep >= 25
                 trainersleep = _INTL("Deprived")
                 sleepColor=Color.new(255,125,55)
                else
                 if $player.playersleep <= 24
                   trainersleep= _INTL("Dying")
                   sleepColor=Color.new(255,55,55)
			    end
			   end
           end
         end
       end 
    $PokemonGlobal.startTime = pbGetTimeNow if !$PokemonGlobal.startTime
    starttime = _INTL("{1} {2}, {3}",
                      pbGetAbbrevMonthName($PokemonGlobal.startTime.mon),
                      $PokemonGlobal.startTime.day,
                      $PokemonGlobal.startTime.year)
    textPositions = [
       [_INTL("Name"), 34, 70, 0, baseColor, shadowColor],
       [$player.name, 302, 70, 1, baseColor, shadowColor],
       [_INTL("ID No."), 332, 70, 0, baseColor, shadowColor],
       [sprintf("%05d", $player.public_ID), 468, 70, 1, baseColor, shadowColor],
       [_INTL("Health"),40,118,0,baseColor,shadowColor],
       [_INTL(trainerhealth),302,118,1,healthColor,shadowColor],
       [_INTL("{1}%",$player.playerhealth.to_s_formatted),190,118,1,healthColor,shadowColor],
       [_INTL("FOD"),34,166,0,baseColor,shadowColor],
       [_INTL(trainerhunger),302,166,1,hungerColor,shadowColor],
       [_INTL("{1}%",$player.playerfood.to_s_formatted),190,166,1,hungerColor,shadowColor],
       [_INTL("H20"),34,214,0,baseColor,shadowColor],
       [_INTL(trainerthirst),302,214,1,thirstColor,shadowColor],
       [_INTL("{1}%",$player.playerwater.to_s_formatted),190,214,1,thirstColor,shadowColor],
       [_INTL("SLP"),34,262,0,baseColor,shadowColor],
       [_INTL(trainersleep),302,262,1,sleepColor,shadowColor],
       [_INTL("{1}%",$player.playersleep.to_s_formatted),190,262,1,sleepColor,shadowColor]
    ]
    pbDrawTextPositions(overlay, textPositions)

    x = 72
    region = pbGetCurrentRegion(0) # Get the current region
    imagePositions = []
    8.times do |i|
      if $player.badges[i + (region * 8)]
        imagePositions.push(["Graphics/Pictures/Trainer Card/icon_badges", x, 310, i * 32, region * 32, 32, 32])
      end
      x += 48
    end
    pbDrawImagePositions(overlay, imagePositions)

  end


  def pbSurvivalCard(vari=false)
    selection = 0 
    loop do
      Graphics.update
      Input.update
      pbUpdate
      if Input.trigger?(Input::BACK)
        break
      end
    end
  end

  def pbEndScene
    pbFadeOutAndHide(@sprites) { pbUpdate }
    pbDisposeSpriteHash(@sprites)
    @viewport.dispose
  end
#===============================================================================
#
#===============================================================================

class PokemonSurvivalCardScreen
  def initialize(scene)
    @scene = scene
  end

  def pbStartScreen(vari=false)
    @scene.pbStartScene(vari)
    @scene.pbSurvivalCard(vari)
    @scene.pbEndScene
  end
end

#Call SurvivalCardStart.cardwindow
module SurvivalCardStart
  def self.cardwindow
    pbFadeOutIn {
      scene = SurvivalModeCard_Scene.new
      screen = PokemonSurvivalCardScreen.new(scene)
      screen.pbStartScreen
    }
  end
end 