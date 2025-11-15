= 充电控制系统输入端口数学建模

设编号为j的CCU的第i个输入端口为：$"CjPi"$，例如第二个终端的第一个输入端口表示为: $"C2P1"$。
为了表示功率需求，输入端口需要具备需求电压、需求电流的属性。要求系统具备功率调度能力，因此输入端口
需要具备插枪状态、允许功率输出状态。端口的数学模型属性如表 @输入端口数学模型 所示。
#figure(
  table(
    columns: 3,
    stroke: (x: none, y: none),
    align: (center, center, center),
    inset: 10pt,
    table.hline(),
    table.header([*Parameter*], [*Symbol*], [*Description*]),
    table.hline(),
    [需求电压], [$V_"req"$], [输入端口请求的电压值],
    [需求电流], [$I_"req"$], [输入端口请求的电流值],
    [插枪状态], [$S_"plug"$], [充电枪连接状态],
    [允许充电状态], [$P_"enable"$], [端口输入功率的使能状态],
    table.hline()
  ),
  caption: [输入端口数学模型]
) <输入端口数学模型>

$C_j P_i$端口空闲时，向EMS发送的信息$C_j P_i . S_"plug" $为false表示充电枪未连接。当充电枪与车端连接后$C_j P_i . S_"plug"$为true。当开始充电时，
例如$C_j P_i$端口已经与车端连接并准备进行充电，CCU立即向EMS发送功率请求，
请求EMS向编号为$j$的CCU所控制的编号为$i$的端口输出请求的电压$C_j P_i . V_"req"$与电流$C_j P_i . I_"req"$，
并携带$C_j P_i . S_"plug"$与$C_j P_i . P_"enable"$信息。

此模型需要向外提供数据获取与设置的接口，如表@输入端口对应的接口 所示。

#figure(
  table(
    columns: 2,
    stroke: (x: none, y: none),
    align: (center, center, center),
    inset: 10pt,
    table.hline(),
    table.header([*Interface*], [*Description*]),
    table.hline(),

    [_ setRVoltageReq(port, voltage) _], [设置端口需求电压值],
    [_ setCurrentReq(port, current) _], [设置端口需求电流值],
    [_ setPlugStatus(port, plug_status) _], [设置端口与车端的连接状态],
    [_ setPowerStatus(port, enable) _], [设置端口功率输入状态],

    [_ getRVoltageReq(port, voltage) _], [获取端口需求电压值],
    [_ getCurrentReq(port, current) _], [获取端口需求电流值],
    [_ getPlugStatus(port, plug_status) _], [获取端口与车端的连接状态],
    [_ getPowerStatus(port, enable) _], [获取端口功率输入状态],
    table.hline()
  ),
  caption: [输入端口对应的接口]
) <输入端口对应的接口>

= 功率控制系统建模

设编号j的功率柜第i个输出端口为$P_j P_i$。例如第1个功率柜的第2个输出端口表示为$P_1 P_2$。
输出端口需要告知EMS该端口当前输出的功率，当前可输出的功率上限以及最小调度功率值(单个电源模块输出功率)。
PCU将所有端口的数据持续发送至EMS，并对EMS的功率需求进行响应。PCU为了能更快响应功率调度，需要一个
输出准备信号$P_j P_i S_"req"$以及允许输出信号$P_j P_i P_"enable"$。分别对应输入端口的
$C_j P_i S_"plug"$与$C_j P_i P_"enable"$。输出端口的数学模型如表@输出端口数学模型 所示。

#figure(
  table(
    columns: 3,
    stroke: (x: none, y: none),
    align: (center, center, center),
    inset: 10pt,
    table.hline(),
    table.header([*Parameter*], [*Symbol*], [*Description*]),
    table.hline(),
    [需求电压], [$V_"req"$], [输出端口请求的电压值],
    [需求电流], [$I_"req"$], [输出端口请求的电流值],
    [需求准备状态], [$S_"req"$], [输出端口准备状态],
    [允许充电状态], [$P_"enable"$], [端口输出功率的使能状态],
    [当前电压], [$V_"fb"$], [输出端口当前电压值],
    [当前电流], [$I_"fb"$], [输出端口当前电流值],
    [当前准备状态], [$S_"fb"$], [输出端口当前状态],
    [当前最大输出功率], [$P_"max"$], [输出端口当前可提供的最大功率],

    table.hline()
  ),
  caption: [输出端口数学模型]
) <输出端口数学模型>

此模型需要向外提供数据获取与设置的接口 如表所示。

#figure(
  table(
    columns: 2,
    stroke: (x: none, y: none),
    align: (center, center, center),
    inset: 10pt,
    table.hline(),
    table.header([*Interface*], [*Description*]),
    table.hline(),

    [_ setOutputVoltage(port, voltage) _], [设置输出端口电压值],
    [_ setOutputCurrent(port, current) _], [设置输出端口电流值],
    [_ setOutputPowerMax(port, power) _], [设置输出端口最大功率值],
    [_ setOutputStatus(port, status) _], [设置输出端口准备状态],
    [_ enableOutput(port, enable) _], [使能或禁止输出端口功率输出],
    [_ getOutputVoltage(port) _], [获取输出端口电压值],
    [_ getOutputCurrent(port) _], [获取输出端口电流值],
    [_ getOutputPowerMax(port, power) _], [获取输出端口最大功率值],
    [_ getOutputStatus(port) _], [获取输出端口准备状态信息],

    table.hline()
  ),
  caption: [输出端口对应的接口]
) <输出端口对应的接口>
