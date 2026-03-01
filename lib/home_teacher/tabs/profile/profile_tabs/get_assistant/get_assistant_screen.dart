import 'package:flutter/material.dart';
import '../../../../../BackendSetup Data/Api/api_service.dart';
import '../../../../../provider/app_flow.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_text.dart';
import '../../../../../utils/responsive.dart';
import 'assistant_model.dart';

class GetAssistantScreen extends StatefulWidget {
  const GetAssistantScreen({super.key});

  @override
  State<GetAssistantScreen> createState() => _GetAssistantScreenState();
}

class _GetAssistantScreenState extends State<GetAssistantScreen> {
  List<AssistantModel> assistants = [];

  @override
  void initState() {
    super.initState();
    fetchAssistants();
  }

  Future<void> fetchAssistants() async {
    final token = await AppFlow.getTeacherToken();

    final api = ApiService(token: token);

    try {
      final result = await api.getAssistants();
      setState(() {
        assistants = result;
      });
    } catch (e) {
      print("Error fetching assistants: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          "المساعدين",
          style: AppText.boldText(
            color: AppColors.blackColor,
            fontSize: sp(25),
          ),
        ),
        backgroundColor: AppColors.strokeBottomNavBarColor,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_forward_ios_sharp, size: h(25)),
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(30)),
        itemCount: assistants.length,
        separatorBuilder: (_, __) => SizedBox(height: h(20)),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(20)),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.strokeBottomNavBarColor,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.strokeBottomNavBarColor,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    assistants[index].name,
                    style: AppText.regularText(
                      color: AppColors.greyColor,
                      fontSize: sp(20),
                    ),
                  ),
                ),
                Text(
                  assistants[index].code.toString(),
                  style: AppText.regularText(
                    color: AppColors.greyColor,
                    fontSize: sp(20),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
