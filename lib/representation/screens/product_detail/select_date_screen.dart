import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/dismension_constants.dart';
import '../../widgets/button_widget.dart';

class SelectDateScreen extends StatefulWidget {
  const SelectDateScreen({super.key, this.selectedRentalPeriod
      // , this.rentingDate
      });
  final int? selectedRentalPeriod;
  // final Map<String, List<int>>? rentingDate;
  static const String routeName = '/select_date_screen';

  @override
  State<SelectDateScreen> createState() => _SelectDateScreenState();
}

class _SelectDateScreenState extends State<SelectDateScreen> {
  DateTime? rangeStartDate;
  DateTime? rangeEndDate;
  int? selectedRentalPeriod;
  DateRangePickerController controller = DateRangePickerController();

  // List<DateTime> bookedDates = [];
  // List<DateTime> disabledDates = [];
  @override
  void initState() {
    super.initState();
    selectedRentalPeriod = widget.selectedRentalPeriod ?? 0;

    // if (widget.rentingDate != null && widget.rentingDate!.isNotEmpty) {
    //   updateBookedDates(widget.rentingDate!);
    // }
    // for (var period in apiResponse) {
    //   DateTime startDate = DateTime(period["startDate"]![0],
    //       period["startDate"]![1], period["startDate"]![2]);
    //   DateTime endDate = DateTime(
    //       period["endDate"]![0], period["endDate"]![1], period["endDate"]![2]);
    //   for (int i = 1; i <= 4; i++) {
    //     DateTime disabledDate = endDate.add(Duration(days: i));
    //     bookedDates.add(disabledDate);
    //   }
    //   for (DateTime date = startDate;
    //       date.isBefore(endDate.add(Duration(days: 1)));
    //       date = date.add(Duration(days: 1))) {
    //     bookedDates.add(date);
    //   }
    // }
  }

  // void updateBookedDates(Map<String, List<int>>? rentingDate) {
  //   bookedDates.clear();
  //   if (rentingDate != null) {
  //     DateTime startDate = DateTime(
  //       rentingDate["startDate"]![0],
  //       rentingDate["startDate"]![1],
  //       rentingDate["startDate"]![2],
  //     );
  //     DateTime endDate = DateTime(
  //       rentingDate["endDate"]![0],
  //       rentingDate["endDate"]![1],
  //       rentingDate["endDate"]![2],
  //     );
  //     // -
  //     for (int i = 1; i <= 2; i++) {
  //       DateTime disabledDate = startDate.subtract(Duration(days: i));
  //       bookedDates.add(disabledDate);
  //     }
  //     for (int i = 1; i <= 4; i++) {
  //       DateTime disabledDate = endDate.add(Duration(days: i));
  //       bookedDates.add(disabledDate);
  //     }
  //     for (DateTime date = startDate;
  //         date.isBefore(endDate.add(Duration(days: 1)));
  //         date = date.add(Duration(days: 1))) {
  //       bookedDates.add(date);
  //     }
  //   }
  // }

  bool isAnyDateDisabled(
    DateTime startDate,
    DateTime endDate,
    DateTime disableStartDate,
  ) {
    for (DateTime date = startDate;
        date.isBefore(endDate.add(Duration(days: 1)));
        date = date.add(Duration(days: 1))) {
      if (date.isBefore(disableStartDate)) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(239, 240, 242, 1),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            FontAwesomeIcons.angleLeft,
          ),
        ),
        title: Center(child: Text('Chọn ngày')),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          SfDateRangePicker(
            // selectableDayPredicate: (DateTime date) {
            //   DateTime disableStartDate =
            //       DateTime.now().add(Duration(days: 16));
            //   return date.isBefore(disableStartDate);
            // },
            controller: controller, // sử dụng controller để quản lý ngày
            minDate: DateTime.now().add(Duration(days: 3)),
            maxDate: DateTime.now().add(Duration(days: 16)),
            view: DateRangePickerView
                .month, // chế độ hiển thị theo tháng/năm/thập kỷ
            selectionMode: DateRangePickerSelectionMode
                .range, //range là chọn phạm vi, single chọn 1 ngày, multiple chọn nhiều ngày
            monthViewSettings: DateRangePickerMonthViewSettings(
                firstDayOfWeek: 1,
                showTrailingAndLeadingDates:
                    true), // chế độ hiển thị theo tháng, ngày đầu tuần 1 là thứ 2
            selectionColor: ColorPalette.primaryColor,
            startRangeSelectionColor: ColorPalette.primaryColor,
            endRangeSelectionColor: ColorPalette.primaryColor,
            rangeSelectionColor: ColorPalette.hideColor,
            todayHighlightColor: Colors.redAccent,
            toggleDaySelection:
                true, // cho phép người  dùng chọn 1 ngày đã chọn trước đó để hủy chọn

            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              // DateRangePickerSelectionChangedArgs là object chứa thông tin về lựa chọn ngày được thay đổi
              // khi mà người dùng chọn xong ngày bắt đầu và ngày kết thúc thì nó sẽ gán vào 2 biến này

              if (args.value.startDate != null) {
                rangeStartDate = args.value.startDate;
                if (selectedRentalPeriod != null) {
                  rangeEndDate = rangeStartDate!
                      .add(Duration(days: selectedRentalPeriod! - 1));
                  controller.selectedRange = PickerDateRange(rangeStartDate!,
                      rangeEndDate!); // dùng controller này để cập nhật lại UI
                }
              }
            },
          ),
          SizedBox(height: kBottomBarIconSize20),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kBottomBarIconSize20),
            child: ButtonWidget(
              title: 'Chọn',
              onTap: () {
                Navigator.of(context).pop([rangeStartDate, rangeEndDate]);
              },
              height: 70,
              size: 18,
            ),
          ),
          SizedBox(
            height: kDefaultPadding16,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kBottomBarIconSize20),
            child: ButtonWidget(
              title: 'Hủy',
              onTap: () {
                rangeStartDate = null;
                rangeEndDate = null;
                Navigator.of(context).pop([rangeStartDate, rangeEndDate]);
              },
              height: 70,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
