import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../../core/services/service_barrel.dart';
import '../../../../core/utils/app_images.dart';
import '../../../data/models/response/response_barrel.dart';
import '../../../domain/usecases/usecase_barrel.dart';
import '../base_view.dart';

class HomePage extends BaseView {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends BaseViewState<HomePage> {
  TokenService tokenService = injection();
  late final GetTicketDetailsUseCase _getTicketDetailsUseCase;

  bool loading = true;
  List<TicketDetailDTOList> _ticketList = [];

  double progress = 0;
  int totalTickets = 0;
  int scannedTickets = 0;

  @override
  void initState() {
    super.initState();
    _getTicketDetailsUseCase = injection();
    _fetchTicketDetails();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: 16.h,
            width: double.infinity,
            child: SvgPicture.asset(
              AppImages.icHomeBg,
              fit: BoxFit.fitHeight,
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        'Welcome',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: const Color(0xFFFF2C37),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        tokenService.getUser()?.firstName ?? '',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        AppImages.icSettings,
                        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 1.h),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: loading
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                      children: [
                        _buildTotalStatsCard(progress, totalTickets, scannedTickets),
                        SizedBox(height: 2.h),
                        _buildStatsGridView(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalStatsCard(double progressValue, int totalTickets, int scannedTickets) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2.h),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),

          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    startAngle: 270,
                    endAngle: 630,
                    showLabels: false,
                    showTicks: false,
                    axisLineStyle: const AxisLineStyle(
                      thickness: 0.15,
                      color: Colors.black12,
                      thicknessUnit: GaugeSizeUnit.factor,
                    ),
                    pointers: <GaugePointer>[
                      RangePointer(
                        value: progressValue,
                        width: 0.15,
                        sizeUnit: GaugeSizeUnit.factor,
                        gradient: const SweepGradient(
                          colors: [Color(0xFFFF2C37), Color(0xFF221F1F)],
                          stops: [0.25, 1.0],
                        ),
                        cornerStyle: CornerStyle.bothCurve,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        positionFactor: 0.1,
                        angle: 90,
                        widget: Text(
                          "${progressValue.toInt()}%",
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text(
                      'Total Tickets',
                      style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$totalTickets',
                      style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Scanned',
                      style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$scannedTickets',
                      style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGridView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _ticketList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) {
          final ticket = _ticketList[index];
          final total = ticket.purchaseTickets ?? 0;
          final scanned = ticket.onBordTicket ?? 0;
          final gaugeProgress = total > 0 ? (scanned / total) * 100 : 0;

          return Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Expanded(
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 100,
                        startAngle: 270,
                        endAngle: 630,
                        showLabels: false,
                        showTicks: false,
                        axisLineStyle: const AxisLineStyle(
                          thickness: 0.15,
                          color: Colors.white24,
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                        pointers: <GaugePointer>[
                          RangePointer(
                            value: gaugeProgress.toDouble(),
                            width: 0.15,
                            sizeUnit: GaugeSizeUnit.factor,
                            gradient: const SweepGradient(
                              colors: [Color(0xFFFF2C37), Colors.white],
                              stops: [0.25, 1.0],
                            ),
                            cornerStyle: CornerStyle.bothCurve,
                          ),
                        ],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(
                            positionFactor: 0.1,
                            angle: 90,
                            widget: Text(
                              '${gaugeProgress.toInt()}%',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  ticket.ticketType ?? "Unknown",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _fetchTicketDetails() async {
    setState(() {
      loading = true;
    });

    final result = await _getTicketDetailsUseCase.call(const Params([]));

    result.fold(
          (failure) {
        setState(() => loading = false);
        handleErrors(failure: failure);
      },
          (response) {
        final ticketList = response.data?.ticketDetailDTOList ?? [];

        int total = 0;
        int scanned = 0;

        for (final ticket in ticketList) {
          total += ticket.purchaseTickets!;
          scanned += ticket.onBordTicket!;
        }

        setState(() {
          _ticketList = ticketList;
          totalTickets = total;
          scannedTickets = scanned;
          progress = total > 0 ? ((scanned / total) * 100).toDouble() : 0;
          loading = false;
        });
      },
    );
  }


}
