(define (domain robot-object-move)
  (:predicates (room ?r)
               (object ?o)
               (robot ?ro)
               (at-room ?r)
               (at ?o ?r)
               (free ?ro)
	       (freeroom ?r)
               (wall ?r ?r)
               (carry ?o ?ro)
               (allow ?r ?r))
              
  (:action movewithoutobject
    :parameters (?from ?to ?robot)
    :precondition (and (room ?from) (room ?to) (robot ?robot) (at-room ?from) (allow ?from ?to) (free ?robot) (not (wall ?from ?to)))
    :effect (and (at-room ?to) (not (at-room ?from))))

  (:action movewithobject
    :parameters (?obj ?from ?to ?robot)
    :precondition (and (object ?obj) (room ?from) (room ?to) (robot ?robot) (at-room ?from) (allow ?from ?to) (not (free ?robot)) (freeroom ?to) (carry ?obj ?robot) (not (wall ?from ?to)))
    :effect (and (at-room ?to) (not (at-room ?from))))

  (:action pickup
    :parameters (?obj ?room ?robot)
    :precondition (and (object ?obj) (room ?room) (robot ?robot) (not (freeroom ?room)) (at ?obj ?room) (at-room ?room) (free ?robot))
    :effect (and (carry ?obj ?robot) (freeroom ?room) (not (at ?obj ?room)) (not (free ?robot))))
 
  (:action release
    :parameters (?obj ?room ?robot)
    :precondition (and (object ?obj) (room ?room) (robot ?robot) (freeroom ?room) (carry ?obj ?robot) (at-room ?room) (not (free ?robot))) 
    :effect (and (at ?obj ?room) (free ?robot) (not (freeroom ?room)) (not (carry ?obj ?robot)))))
