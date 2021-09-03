extends StateMachine


func _on_AttackRange_body_entered(body: Node) -> void:
  if body.is_in_group("defense"):
    state.enemy.target = body
    state.exit("AttackPlayerDefenses")

