def hud(movimento, sala):
    return f"""-
-                                   {movimento[0]:^10}
-
-                                      North
-                                      
-                                    {sala[1]:^10}
-
-                     West {sala[3]:>10}{sala[0]:^10}{sala[4]:<10} East
-
-                                    {sala[2]:^10}
-                                      
-                                      South
-
"""