extends Resource
class_name Classes


class EntityData extends Resource:
    @export var health: int
    @export var damage: int
    @export var speed: float
    signal on_died
    signal on_injured(damage: float)

    func is_died():
        return health <= 0;
        
    func _init():
        health = 0
        damage = 0
        speed = 0

    func take_damage(_damage: int):
        health -= _damage
        if !on_injured.is_null():
            on_injured.emit(damage)
        if is_died() && !on_died.is_null():
            on_died.emit()

    static func construct(_health: int, _damage: int, _speed: float):
        var temp_entity = EntityData.new()
        temp_entity.health = _health;
        temp_entity.damage = _damage
        temp_entity.speed = _speed
        return temp_entity