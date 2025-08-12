import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/services/service_barrel.dart';
import '../../../../core/utils/utils_barrel.dart';
import '../../../data/models/response/response_barrel.dart';
import '../../../domain/usecases/usecase_barrel.dart';
import '../../widgets/widgets_barrel.dart';
import '../base_view.dart';
import 'history_barrel.dart';

class HistoryPage extends BaseView {
  const HistoryPage({super.key});

  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends BaseViewState<HistoryPage> {
  final GetTicketHistoryUseCase _getTicketHistoryUseCase = injection();

  DateTime? date;
  TicketDetails? type;

  List<TicketDetails> history = [];
  List<TicketDetails> filteredHistory = [];
  bool isLoading = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchTicketHistory();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) {
      setState(() => filteredHistory = List.from(history));
    } else {
      setState(() {
        filteredHistory = history.where((ticket) {
          final nameMatch = ticket.userName?.toLowerCase().contains(query) ?? false;
          final ticketIdMatch = ticket.ticketId?.toLowerCase().contains(query) ?? false;
          final verifyIdMatch = ticket.verifyId?.toLowerCase().contains(query) ?? false;
          return nameMatch || ticketIdMatch || verifyIdMatch;
        }).toList();
      });
    }
  }


  @override
  Widget buildView(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTitle(size),
            SizedBox(height: 2.h),
            _buildSearchBar(),
            SizedBox(height: 2.h),
            if (_isFilterEnabled()) _buildFilterTags(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _buildBookingList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: _searchController,
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: 'Search by Name , Ticket ID or Verify ID ',
          hintStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: const Icon(Icons.search, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black, width: 1.5),
          ),
        ),
      ),
    );
  }


  Widget _buildTitle(Size size) {
    return SizedBox(
      width: size.width - 40,
      child: Text(
        _isFilterEnabled() ? "Filtered Tickets  ⛶" : "Scanned History  ⛶",
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.w900,
          height: 1.6,
          color: const Color(0xFF1B1B1B),
        ),
      ),
    );
  }

  Widget _buildFilterTags() {
    return SizedBox(
      width: 100.w - 40,
      child: Wrap(
        spacing: 2.w,
        children: [
          if (type != null)
            FilterTag(
              value: type?.eventCategory,
              onRemove: () {
                setState(() => type = null);
                _fetchTicketHistory();
              },
            ),
        ],
      ),
    );
  }

  Widget _buildBookingList() {
    if (isLoading) {
      return _buildSkeletonList();
    }
    if (filteredHistory.isEmpty) {
      return EmptyWidget(
        title: _isFilterEnabled()
            ? 'No Filtered Tickets!'
            : 'No Tickets yet!',
        message: _isFilterEnabled()
            ? 'Your filtered Tickets will appear here once confirmed.'
            : 'Your Tickets will appear here once scanned.',
        icon: AppImages.icHistory,
      );
    }
    return ListView.builder(
      itemCount: filteredHistory.length,
      itemBuilder: (context, index) {
        return _itemBuilder(context, filteredHistory[index]);
      },
    );
  }


  Widget _buildSkeletonList() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            height: 80,
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(height: 14, width: 120, color: Colors.grey[300]),
                      const SizedBox(height: 8),
                      Container(height: 12, width: 200, color: Colors.grey[300]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _isFilterEnabled() {
    return type != null;
  }

  Future<void> _fetchTicketHistory() async {
    setState(() => isLoading = true);

    final result = await _getTicketHistoryUseCase.call(const Params([]));
    setState(() => isLoading = false);

    if (result.isRight()) {
      final response = result.getOrElse(() => GetTicketHistory());
      setState(() {
        history = response.data ?? [];
        filteredHistory = List.from(history);
      });
    } else {
      final failure = result.fold((l) => l, (r) => null);
      handleErrors(failure: failure!);
    }
  }

  Widget _itemBuilder(BuildContext context, TicketDetails ticket) {
    return HistoryCard(
      onCardClick: () {
        showTicketHistorySheet(ticket);
      },
      ticket: ticket,
    );
  }

  void showTicketHistorySheet(TicketDetails ticket) {
    openBottomSheet(page: BookingDetailsSheet(
      ticket: ticket,
    ));
  }
}
