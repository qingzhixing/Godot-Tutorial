extends Resource
class_name Classes

class EntityData extends Resource:
    @export var health: float
    @export var damage: float
    @export var speed: float

    func is_died():
        return health <= 0;
        
    func _init():
        health = 0
        damage = 0
        speed = 0

    func take_damage(_damage: float):
        print("Take damage: ", _damage)
        health -= _damage
        print("Leave health: ", health)

    static func construct(_health: float, _damage: float, _speed: float):
        var temp_entity = EntityData.new()
        temp_entity.health = _health;
        temp_entity.damage = _damage
        temp_entity.speed = _speed
        return temp_entity