import ceramic.Sound;
import ceramic.StateMachineBase;
import ceramic.Text;
import ceramic.Quad;
import ceramic.Color;
import ceramic.Scene;

using ceramic.VisualTransition;
class MainMenu extends Scene {
    var sceneText = new Text();
    var title = new Text();
    var square:Square;
    var options:MenuOptions;
    override function preload() {
        assets.add(Fonts.DAYDREAM);
        assets.add(Fonts.GRAPE_SODA);
        assets.add(Sounds.BLIP);
        assets.add(Sounds.MENU_OPTION_CHANGE);
        assets.add(Sounds.TITLE_HIT);
    }
    override function create() {
        super.create();
        options = new MenuOptions(assets.font(Fonts.GRAPE_SODA));
        add(options);

        square = new Square(150);
        add(square);

        square.depth = -20;
        square.pos(width / 2, height / 2);
        add(square);

        //add scene name
        sceneText.content = "Main Menu";
        sceneText.pointSize = 15;
        sceneText.align = CENTER;
        sceneText.font = assets.font(Fonts.DAYDREAM);
        sceneText.pos(10, 10);
        add(sceneText);

        title.content = "Doin' It";
        title.align = CENTER;
        title.pointSize = 40;
        title.anchor(0.5, 0.5);
        title.pos(width * 0.5, height * 0.4); //height * 0.4
        title.font = assets.font(Fonts.DAYDREAM);
        add(title);

        title.tween(LINEAR, 0.1, 120, 40, (v, t) -> {
            title.pointSize = v;
        });
        assets.sound(Sounds.TITLE_HIT).play();
        title.onPointerDown(this, info -> {
            app.scenes.main = new MainScene();
        });
        input.onKeyDown(this, options.keyUp);
    }

    override function update(delta:Float) {
        sceneText.pos(10, 10);
        title.pos(width * 0.5, height * 0.4);
        square.update(delta);
    }

    override function destroy() {
        super.destroy();
    }
    override function resize(width, height:Float) {
        super.resize(width, height);
        if (options != null) {
            options.resize();
        }
    }
}
class MenuOptions extends ceramic.Visual {
    var index = 1;
    public var begin: Text;
    public var credits: Text;
    public function new(font:ceramic.BitmapFont) {
        super();
        begin = new Text();
        begin.content = "BEGIN";
        begin.font = font;
        begin.color = Color.RED;
        begin.anchor(0.5, 0.5);
        begin.pointSize = 20;
        begin.scale(2.8, 2.8);
        begin.align = CENTER;
        //begin.pos(width * 0.4, height * 0.5);

        credits = new Text();
        credits.content = "CREDITS";
        credits.font = font;
        credits.color = Color.GRAY;
        credits.anchor(0.5, 0.5);
        credits.pointSize = 20;
        credits.scale(2.2, 2.2);
        credits.align = CENTER;

        this.anchor(0.5, 1);
        resize();

        add(credits);
        add(begin);
    }
    public function keyUp(key:ceramic.Key) {
            switch (key.scanCode) {
                case RIGHT:
                    if (index == 1) {
                        index = 2;
                    } else {
                        index = 1;
                    }
                    updateIndex();
                case LEFT:
                    if (index == 2) {
                        index = 1;
                    } else {
                        index = 2;
                    }
                    updateIndex();
                case ENTER:
                    if (index == 1) {
                        app.scenes.main = new MainScene();
                    } else {
                        return;
                    }
                case _:
                    return;
            }
    }
    //resizes menu to fit new scene/screen size
    public function resize() {
        this.size(screen.width, screen.height / 3.5);
        this.pos(screen.width * 0.5, screen.height - 10);
        begin.pos(width * 0.4, height * 0.5);
        credits.pos(width * 0.6, height * 0.5);
    }
    function updateIndex() {
        app.scenes.main.assets.sound(Sounds.MENU_OPTION_CHANGE).play();
        switch (index) {
            case 1:
                begin.transition(LINEAR, 0.3, begin -> {
                    begin.scale(2.8);
                    begin.color = Color.RED;
                });
                credits.transition(LINEAR, 0.1, credits -> {
                    credits.scale(2);
                    credits.color = Color.GRAY;
                });
            
            case 2:
                credits.transition(LINEAR, 0.3, credits -> {
                    credits.scale(2.8);
                    credits.color = Color.CYAN;
                });
                begin.transition(LINEAR, 0.1, begin -> {
                    begin.scale(2);
                    begin.color = Color.GRAY;
                });
            case _:
                index = 1;
        }
    }
}
class Square extends ceramic.Quad {
    var vx:Float;
    var vy:Float;
    public function new(velocity:Float) {
        super();
        size(30, 30);
        anchor(0.5, 0.5);
        this.vx = velocity;
        this.vy = velocity;

    }
    public function update(dt:Float) {
        x += vx * dt;
        y += vy * dt;
        wallBounce();
        /*this.tween(LINEAR, 1, 0, sq.x + vx * dt, (v, t) -> {
            sq.x = v;
        });
        this.tween(LINEAR, 1, 0, sq.y + vy * dt, (v, t) -> {
            sq.y = v;
        });*/
    }
    public function wallBounce() {
        if (x <= width || x >= screen.width - width) {
            vx = -vx;
            app.scenes.main.assets.sound(Sounds.BLIP).play();
        }
        if (y <= height || y >= screen.height - height) {
            vy = -vy;
            app.scenes.main.assets.sound(Sounds.BLIP).play();
        }
    }
}