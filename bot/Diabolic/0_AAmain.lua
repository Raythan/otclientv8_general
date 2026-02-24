-- main UI.Separator()


 UI.Separator()


 local loadPanelName = "Luiz"
  local ui = setupUI([[
Panel

  height: 20

  Label
    id: editLuiz
    color: pink
    font: verdana-11px-rounded
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 20
    text: .       - Discord: Luiz#7159  -      .


  ]], parent)


ui.editLuiz.onClick = function(widget)
end

 local loadPanelName = "Discord"
  local ui = setupUI([[
Panel

  height: 20

  Button
    id: editDiscord
    color: red
    font: verdana-11px-rounded
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: 20
    text: - Discord  -
    tooltip: Grupo no discord


  ]], parent)


ui.editDiscord.onClick = function(widget)
g_platform.openUrl("https://discord.gg/yVxRHbNHpK")
end UI.Separator()


 UI.Separator()






